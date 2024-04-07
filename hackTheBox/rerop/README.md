
# "ReRop" by Hack The Box

Sometimes everything looks scarier than it really is, like in this task. [ROP](https://en.wikipedia.org/wiki/Return-Oriented_Programming) usually looks like something complicated, but aside from how exactly to apply it, given all the modern methods of protecting against it, the basic approach is quite simple: find and use a sequence of instructions (or "gadgets" as they call it) in the executable that will produce the desired result. This challenge is a simple representation of this idea. 

Apart from a ton of extra and unnecessary code that is in the binary, the verification logic looks like this:

```c
printf("Enter the flag: ");
fgets(input_buf, 64LL, stdin);
check(&magic_here);
puts(input_buf);
```

And that's all. If you think that there should be something in the `check` function, then it is not:

```assembly
.text:00000000004017B5 check           proc near               ; CODE XREF: main+6D↓p
.text:00000000004017B5 ; __unwind {
.text:00000000004017B5                 endbr64
.text:00000000004017B9                 lea     rsp, [rdi]
.text:00000000004017BC                 retn
.text:00000000004017BC check           endp
```

So the only thing it does is reconfigure the stack pointer to this `magic_here` blob that resides in the executable file. What kind of blob is this? It is these "carefully chosen machine instruction sequences" that are needed to execute logic that is not directly represented in the file as functions or other common forms.

I don't know if this object can be easily disassembled, so I decided to run the debugger and follow the code. Luckily, this is fairly trivial. It checks whether the code is running under the debugger, and if not, it executes the following (simplified) logic:

```c
for (int i = 0; i < 0x1D; ++i) {
	if ((input_buf[i] + i) ^ 5 != encrypted_flag[i])
		failed();
}
```

This is not exactly the code that is executed, because there is no real `encrypted_flag` array somewhere. It's more like running the same sequence of gadgets with different values that represent the current `encrypted_flag[i]`. To make it clear, checking the presence of a debugger, the logic for checking the correctness of the flag, printing the result in different colors: all this is here, in the blob. It may look complicated at first, but during a debugging session this repeating pattern is quite obvious, so in the end, you'll know where to look for the next encrypted character.

To reverse the algorithm and get the flag, you can use the following code:

```c
for (int i = 0; i < 0x1D; ++i) {  
	printf("%c", (encrypted_flag[i] ^ 0x05) - i);
}
```

You can find the challenge [here](https://app.hackthebox.com/challenges/ReRop).
