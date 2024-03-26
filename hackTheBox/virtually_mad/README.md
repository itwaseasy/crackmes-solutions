
# "Virtually Mad" by Hack The Box

This challenge implements a simple virtual machine with only 5 instructions. Your task is to write a program for this VM that satisfies some requirements, and the flag will be the bytecode of this program. Pretty interesting!

Each instruction is 4 bytes long and has the following format:

 - nibble 7 and 6 encode the instruction opcode
 - nibble 5 should always be 1
 - nibble 4 encodes the destination register
 - nibble 3 is a flag: if set to 1, nibbles 0–2 encode the source register, otherwise they encode the immediate value

To show which instructions I used, I'll code them like this: `opcode=01 always=1 dst_reg=0 irflag=0 imm_or_src_reg=100` where `irflag` is the “instruction or register flag”. Other fields are self-explanatory.

The VM has only four registers, encoded using their index in the VM state structure: `0=reg_a, 1=reg_b, 2=reg_c, 3=reg_d`. There is also a `flags` register, which can only have one value: `0` or `0x10000000"`. It is used to store the result of the `cmp` instruction: if the comparison is successful, the flags register will have the value `0x10000000`, otherwise, it will be `0`.

These are the opcodes implemented by the virtual machine (where the number is the value of the opcode): `1=mov, 2=add, 3=sub, 4=cmp, 5=exit`. Every opcode except `exit` checks `irflag` to see where the original value came from. For example, the add statement in pseudocode looks like this:

```c
if (irflag == 1)
    value = vm_state.registers[imm_or_src_reg]
else
    value = imm_or_src_reg

vm_state.registers[dst_reg] += value
```

The same logic applies to both the `sub` and `mov` opcodes. The only exception is `cmp`:

```c
if (irflag == 1)
    value = vm_state.registers[imm_or_src_reg]
else
    value = imm_or_src_reg

if vm_state.registers[dst_reg] == value
	vm_state.flags |= 0x10000000
else
	vm_state.flags ^= 0x10000000
```

And that's all a virtual machine can do. Now the task is to write a program, upon completion of which the following conditions must be met:

1. `reg_a` should be equal to `0x200`
2. `reg_b` should be equal to `-1`
3. `reg_c` should be equal to `-1`
4. `reg_d` should be equal to `0`
5. `flags` should be set to `0x10000000`
6. The total number of instructions in the program must be equal to `5`

There are many ways to achieve these goals, so to narrow down the options as much as possible (and subsequently check the flag), crackme places the following restrictions on your program:

1. The first instruction should be `add`, and the `reg_dst` should be `reg_a`
2. The second instruction should be `add`, and the immediate value to add should be equal to `0x100`
3. The third instruction should be `sub`, and and `reg_dst` should be `reg_b`
4. The fourth instruction should be `mov`, and and `reg_dst` should be `reg_c`
5. The fifth instruction should be `cmp`, and and `reg_dst` should be `reg_d`

I think the only option you have is the following program:

```
0: opcode=02 always=1 dst_reg=0(a) irflag=0 imm_or_src_reg=100	 	add	a, 256
1: opcode=02 always=1 dst_reg=0(a) irflag=0 imm_or_src_reg=100		add	a, 256
2: opcode=03 always=1 dst_reg=1(b) irflag=0 imm_or_src_reg=001		sub	b, 1
3: opcode=01 always=1 dst_reg=2(c) irflag=1 imm_or_src_reg=100		mov	c, b
4: opcode=04 always=1 dst_reg=3(d) irflag=0 imm_or_src_reg=000		cmp	d, 0
```
So, if you concatenate the encoded instructions into one line, this will be the correct answer.

The challenge can be found [here](https://app.hackthebox.com/challenges/Virtually%2520Mad).
