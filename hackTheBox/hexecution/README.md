
# "Hexecution" by Hack The Box

Another day, another toy virtual machine challenge from HTB. It doesn't seem complicated, so I'll keep my story short.

This challenge even provides the source code as a text file, so there's no need to search for it in the binary. It looks strange at first glance, but it's the same assembler as before: mov, xor, cmp, and so on, but "encrypted" with some words. It reminded me of my school days, when I found a cracked version of MS Visual Basic translated into Russian, including the programming language itself. So I had to literally write Visual Basic code using Russian words. Strange experience, but it was fun.

The virtual machine itself has 13 instructions (one of which is not used in the provided source code), 6 registers, and an unusual "stack" implementation, which I'll leave for you to figure out. To get you started with the internal structure, I'll say that the stack grows forward, and the SP register is "hardcoded" as the last element of the array used for emulation. This is funny in itself, because you could try to write an exploit that would either break the virtual stack or the underlying array, since neither is controlled in any way.

As usual, I wrote a small disassembler, but now I call it a "translator." Because I didn't disassemble anything, right? I'm translating a strange language into my strange assembly code. And, as usual, I recommend trying to solve the challenge first, and only using my code when you get stuck.

The resulting translated program doesn't look very complicated: it contains a hard-coded flag encrypted with two simple permutation algorithms that can be reversed in two minutes. 

Have fun! 

The challenge can be found [here](https://app.hackthebox.com/challenges/Hexecution) and my awesome translator with the source code [here](https://github.com/itwaseasy/crackmes-solutions/tree/master/hackTheBox/hexecution).
