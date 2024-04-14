# "vmcrack" by Hack The Box

It seems that using a custom virtual machine implementation in CTF challenges is the trend now, so it is used in this task as well. The only thing is that the crackmes that I've seen so far have done this, let's say, at an amateur level. But this example is really cool: it's a full implementation that supports and interprets a subset of the x86 architecture using 64 opcodes, 32/16/8-bit registers, various addressing modes including full Base/Index/Scale/Displacement mode, and more. It can even use the `fs` segment register!

To make life a bit more interesting, the problem has a few anti-debugging techniques, so be prepared if you're going to debug it. I didn't, because I usually prefer to do things statically, but it's interesting to see all these ideas implemented in one binary anyway. I counted 9 different ways to prevent you from debugging it, but there are probably more:

- [TLS Callbacks](https://unprotect.it/technique/tls-callback/). There are three of them, but they have the same idea: the code finds the address of the desired function using the PEB technique and calls it. The function names are hidden using xor with some hard-coded constant that is different for each callback.
	- [CheckRemoteDebuggerPresent](https://unprotect.it/technique/checkremotedebuggerpresent/)
	- [NtQueryInformationProcess](https://unprotect.it/technique/ntqueryinformationprocess/), but it uses the `ProcessDebugObjectHandle` flag
	- [NtThreadInformationThread](https://unprotect.it/technique/ntsetinformationthread/) with the `ThreadHideFromDebugger` flag
- [icebp instruction](https://unprotect.it/technique/ice-0xf1/)
- PEB's [IsDebugged](https://unprotect.it/technique/isdebugged-flag/) flag
- PEB's [NtGlobalFlag](https://unprotect.it/technique/ntglobalflag/) flag
- PEB's [ProcessHeap](https://unprotect.it/technique/heap-flag/) flags
- [Trap Flag](https://unprotect.it/technique/trap-flag/) in the `flags` register
- [int3](https://anti-debug.checkpoint.com/techniques/assembly.html#int3)

Speaking of TLS callbacks, there is another one that is called first and uses the `IsWow64Process2` function to check that the process is running under [WOW64](https://learn.microsoft.com/en-us/windows/win32/winprog64/running-32-bit-applications). If this is not the case or you do not have an `IMAGE_FILE_MACHINE_I386`/`AMD64` machine, it will not start. Just in case, `vmcrack` is a 32-bit binary that emulates x86, so it's somehow justified.

Now let's dive into the actual implementation of the virtual machine. To execute it, only one function is used throughout the code, and it receives only two parameters: the bytecode to be executed and a pointer to the memory block that the machine will use. The memory block size is always constant: `0x10000` for the memory itself and `0x2C` for the registers.

The internal implementation is confusing, and I'm guessing intentionally: there are no separate functions that emulate instructions. It's more like a [stack machine](https://en.wikipedia.org/wiki/Stack_machine) that performs individual steps during emulation. For example, opcode resolution, understanding instruction parameters, addressing modes, and so on. Each step gets data from the stack and returns the result to the stack so that the next one can do its job too. Eventually, when parameter checking and resolution are complete (which are more or less the same across instructions), the logic of the instruction is executed. Each callback gets its parameters in registers (yes, no more stack), which typically looks like this: `eax=dst ecx=src edx=size`, where `dst/src` is either a register or memory, and `size` specifies the size of the operands. I say "usually" because some instructions have special meaning, but most of the time the logic is the same.

The virtual machine has [variable length instructions](https://homepage.cs.uiowa.edu/~dwjones/arch/notes/30varlen.html): the smallest instruction is encoded using two bytes, and the largest takes up to 15 bytes. Some instructions can perform non-trivial logic, so in other words, the VM implements a kind of [CISC](https://en.wikipedia.org/wiki/Complex_instruction_set_computer) architecture. The general coding scheme for *standard* (there are also non-standard) instructions is as follows:

```
General encoding:

- opcode: 1 byte
- first argument
	- operand_type: 1 byte
	- (optional) operand_size: 1 byte
	- operand: 1 to 4 bytes
	- (optional) index_register: 1 byte
	- (optional) scale: 1 byte
	- (optional) displacement: 4 bytes
- (optional) second operand
	- operand_type: 1 byte
	- (optional) operand_size: 1 byte
	- operand: 1 to 4 bytes
	- (optional) index_register: 1 byte
	- (optional) scale: 1 byte
	- (optional) displacement: 4 bytes

Operand types
	- 0x01: register
	- 0x02: memory
	- 0x03: immediate

Operand sizes:
	- 0x01: byte
	- 0x02: word
	- 0x03: dword

Registers:
	0x04: eax/ax/al
	0x08: ecx/cx/cl
	0x0C: edx/dx/dl
	0x10: ebx/bx/bl
	0x14: esp/sp
	0x18: ebp/bp
	0x1C: esi/si
	0x20: edi/di

Argument rules:
	if 'operand_type' is `register`, argument format is 'operand_type operand_size register'
	if 'operand_type' is `memory`, argument format is 'operand_type operand_size base_register index_register scale displacement/4 bytes'
	if 'operand_type' is `immediate`, argument format is 'operand_type immediate_value/4 bytes'
```

Here are some examples:
- `1D 01 03 18`:
	- `1D=push` `01=register` `03=dword` `18=ebp` => `push ebp`
- `1A 01 03 18 01 03 14`:
	- `1A=mov` `01=register` `03=dword` `18=ebp` `01=register` `03=dword` `14=esp` => `mov ebp, esp`
- `09 02 01 20 0C 04 BE BA FE CA 03 7C 00 00 00`: 
	- `09=add` `02=memory` `01=byte` `20=edi` `0C=edx` `04=scale` `BE BA FE CA=displacement` `03=immediate` `7C 00 00 00=immediate_value` => `add byte ptr[edi+edx*4 + 0xCAFEBABE], 0x7C`


To make my life a little easier, I wrote a [small disassembler](https://github.com/itwaseasy/crackmes-solutions/tree/master/hackTheBox/vmcrack/disassembler). All the rules are there, so it may be easier to understand the logic of the virtual machine by reading the code instead of this text.

These are exceptions to the rules described earlier:

- opcodes `0x33 - 0x35` have format `opcode immediate/2 bytes`
- opcodes `0x36 - 0x40` have format `opcode operand_type`

Please refer to the disassembler sources to see which opcodes apply to which x86 instructions. I won't describe it here, except for the one I called `mov_wtf`. The title implies that I was struggling to understand what it does until I saw it used in bytecode and found this [blog post](http://blog.rewolf.pl/blog/? p=102). That is, I didn’t even know that this was possible, but it does exactly as described in the article: it switches from 32-bit mode to 64-bit mode and back! It's really cool.

Okay, I hope that my chaotic description of the VM architecture was more or less clear (or you at least read the disassembler source code), so let’s move on to the task itself.

First of all, every time you do something wrong, it shows some weird text and exits. For example, if you run it under the debugger and run into one of the described anti-debugging techniques, it will do it. If your input is incorrect it will show you something else and so on. In fact, every wrong move has its own text, so this is also a kind of way to debug it :)

These messages are in a binary file, but they are encrypted. To decrypt and print them, a virtual machine and special bytecode are used. If you are going to disassemble the challenge, you will see the following pattern:

```c
if (something_is_wrong) {
	bytecode_decrypt_and_print_message[encrypted_text_offset] = binary_blob_with_encrypted_text_ptr;
	
	bytecode_decrypt_and_print_message[encrypted_text_key_offset] = 0xF00DCAFE; // or any other key

	memset(vm_memory, 0, sizeof(vm_memory));
	run_vm(vm_memory, bytecode_decrypt_and_print_message);

	memset(vm_memory, 0, sizeof(vm_memory));
	run_vm(vm_memory, bytecode_exit);
}
```

As you can see, the same bytecode is used all the time, but to print different messages, the necessary pointers and keys are dynamically added to the bytecode, so when the virtual machine starts, it decrypts and prints it correctly. On top of that, the correct addresses of the `puts` and `exit` functions are assigned in the same way, but the code does so in the TLS callback responsible for the `WOW64` check.

The string encryption algorithm is quite simple, so I used the following IDC script to view the text in IDA:

```c
auto i, current_byte, x;
auto key = 0xF00DCAFE;

current_byte = key;

for (i = get_screen_ea(); byte(i) != 0; i = i + 1) {
	x = byte(i) ^ (current_byte & 0xFF);
	patch_byte(i, x + 0x7C);

	current_byte = current_byte >> 8;
	if (current_byte == 0)
		current_byte = key;
}
```

If you bypassed half the anti-debugging tricks, the virtual machine executes bytecode that reads and validates the input data. Calling `run_vm` with the required bytecode pointer is also covered by another trick, plus some of them are in the bytecode itself, so have fun if you're still trying to debug it. To ensure proper execution of the bytecode, pointers to the `fputs`/`fgets` and `stdin`/`stdout` functions are also dynamically added to it. This is done directly in the `main` function.

Now that the flag has been read from standard input, the call will encrypt it with a set of instructions that shuffle the bits back and forth, and then `memcmp` will check that the input is correct. If not, you will receive another strange message from the AI and it will end. Fortunately, the algorithm is easily reversible and the correct input data can be decoded using the following code:

```c
uint8_t decrypt(uint8_t c, uint8_t xor_byte) {
    uint8_t result = 0;

    __asm {
        mov al, c
        xor al, xor_byte
        inc al
        rol al, 0x1d
        sub al, 0x3e
        neg al
        xor al, 0xc3
        not al
        add al, 0x0e
        ror al, 0x9f
        dec al

        mov result, al
    }

    return result;
}
```

where `c` is the current encrypted character and `xor_byte` is the previous one.

This is probably all you need if your goal is to get the flag because the task will show it if the data entered is correct. But I turned out to be more curious and decided to figure out where the flag was and how it was encrypted.

Unsurprisingly, this uses yet another piece of bytecode, and it's actually quite fun. If you've been analyzing the binary from the beginning, you've probably noticed that the main function also initializes some global variables with pointers to various functions. Some of them look clear: they directly use the Windows API to calculate SHA256 and MD5 hashes. The other one isn't as obvious, but if you know how CRC32 works, you'll recognize it right away. The last one took me a while to figure out until I found a table that also reminded me of something. It turned out that this is an [AES S-box](https://en.wikipedia.org/wiki/Rijndael_S-box) table , and the function performs AES decryption. All of these are used in the final bytecode that decrypts the flag, embedded in a gorgeous ASCII image. To make it a little funnier, the text is also hidden using the same method used for other string data in the binary. Therefore, to understand that the user's input was correct, the task tries to decrypt the flag and checks that the CRC32 of the decrypted blob is equal to `0x4da2c9f6`, which is a hash of the correct data.

To summarize, the flag can be decrypted using the following code:

```python
sha = SHA256.new()
sha.update(correct_input)

md5 = MD5.new()
md5.update(correct_input)

cipher = AES.new(sha.digest(), AES.MODE_CBC, iv=md5.digest())
decrypted = cipher.decrypt(flag)

# decrypt the text
for i in range(len(decrypted)):
    print(f'{((decrypted[i] ^ 0xc1) + 0x7c) & 0xff:c}', end='')
```

The challenge can be found [here](https://app.hackthebox.com/challenges/vmcrack), and my disassembler and decompiled VM code can be found [here](https://github.com/itwaseasy/crackmes-solutions/tree/master/hackTheBox/vmcrack).
