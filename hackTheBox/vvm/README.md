
# "vvm" by Hack The Box

This is the second HTB challenge I've solved that uses a virtual machine. And I'd like to say that [the first one](https://pugachev.io/2024/04/14/vmcrack-by-hack-the-box/) was much more interesting, challenging, and consistent in implementation than this one. In any case, it was quite fun to solve because of the various stack and bitwise exercises you had to deal with.

But let's start from the beginning. It's a custom virtual machine implementation with 28 different opcodes, and everything is stack-based. There are no registers as such, and the stack is used to store the results of calculations.

Each opcode is 4 bytes long and can have 0 to 2 parameters, which are also 4 bytes long. So the coding is pretty simple: no need to deal with bits, different sizes, conditions, etc. Just read the first 4 bytes and then decide, based on that number, how many arguments to read. But the flip side of this simplicity is that each bytecode can emulate things from a simple jump somewhere or push/pop values to crazy things like allocating a block of memory and reading a line from stdin or (my favorite) deleting a newline from a buffer. And to make the picture sadly complete, these two opcodes are not even used in the task.

To make things easier, I wrote a small disassembler that decodes the VM code into what I call a "pseudo-assembler", so don't try to compile it back. I used the `r1`, `r2`, and `sp` registers to make things easier to read, but again, the original code doesn't have registers.

As for the inconsistencies, please pay attention that the `jmp` instruction works a little weird: it starts counting bytes to the destination starting with its argument, not starting with the next instruction. So if you decode it like this:

```assembly
0b 00 00 00 10 00 00 00                             
                                  jmp [0x10*4]
```

the 4 bytes `0x00000010`  will be included in the offset.

Another funny thing is that the author updated the task according to the HTB changelog. I had the previous version and it is a bit more complex at the last step of checking the flag. Well, it happens.

The opcode logic is encrypted in binary, but the XOR (of course) code is the same everywhere, so you can decode it with the following IDA script:

```c
auto i, current_byte, x;
auto key = 0x2a4d21210b2a;
auto function_size = 64;

current_byte = key;

for (i = get_screen_ea(); i < get_screen_ea() + function_size; i = i + 1) {
	x = byte(i) ^ (current_byte & 0xFF);
	patch_byte(i, x);

	current_byte = current_byte >> 8;
	if (current_byte == 0)
		current_byte = key;
}
```

You can read the disassembler output I left on GitHub to get the full picture (I even commented it a bit), but basically, it looks like this:

1. Read the flag from stdin.
2. Check the size of the input data.
3. Compute eight 4-byte integers using not-so-complicated bitwise logic. Each of these integers contains 4 characters from the original input, encoded in some way.
4. Validate that the resulting integers match the numbers hard-coded into the virtual machine code (or calculated dynamically in a previous version).
5. Print the validation result to stdout.

The fun begins with checking the size of the input data. The virtual machine tries to validate it using the following complex mathematical equation:

```
(((((((x * 3) - 6) * 2 + 4) / 2) * 8) + 24) / 10) = 76
```

but in fact, you can skip it simply because before that, it allocates a buffer exactly the same size as the input should be.

It then encodes pairs of 4 characters using the following logic:

1. Take 4 characters from the input string. For example, the first integer will contain characters from positions `0x18`, `0x0E`, `0x1B` and `0x0F`.
2. Group them into a single integer using standard bitwise logic: `(c0 | c1 << 0x08) | (c2 << 0x10) | (c3 << 0x18)`
3. For each pair, calculate the resulting number: `(previous_step_value << Z) | (previous_step_value >> (0x20 - Z))`, where `Z` is chosen for each pair separately.

So, for example, for the pair `ABCD` the following will be done:

```
step1: pair1 = 'ABCD'
step2: round1 = ('A' | 'B' << 0x08) | ('C' << 0x10) | ('D' << 0x18)
step3: Z = 0x05
step4: round2 = (round1 << 0x05) | (round1 >> 0x1B)
```
and then it will compare the value of `round2` with the hardcoded value to check if the input is correct.

To reverse the algorithm, as usual, you need to go in the opposite direction:

1. Get the hardcoded value (which is ours `round2`) and `Z` from the VM code.
2. Restore the value `round1` by shifting and ORing it in the opposite direction.
3. Put the resulting characters from the value `round1` back to their original positions.

Well, and that's all.

The challenge can be found [here](https://app.hackthebox.com/challenges/vvm) and my awesome IDA-killer and the VM code can be found [here](https://github.com/itwaseasy/crackmes-solutions/tree/master/hackTheBox/vvm).
