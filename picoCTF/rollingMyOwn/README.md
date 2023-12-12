### Rolling My Own by picoCTF

This is a good example of the idea described in a very poorly written [paper](https://link.springer.com/article/10.1007/s11416-006-0011-3). 

The protection scheme is based on knowing the correct password (as usual), but the funny thing is that the entered keyword serves as the entry point for the dynamic code generation algorithm. If the keyword is correct, the generated code is also correct in terms of bytecode and logic, so the check procedure can return a flag. A wrong password can cause garbage generation and application crash, so this is kind of a way of saying "try again".

Anyway, the application requires you to enter a password of 16 characters. No checking for input length, character types or anything, just crash if something is wrong. At the next stage, the password and some predefined constant string (`GpLaMjEWpVOjnnmkRGiledp6Mvcezxls`) are divided into 4 parts and then combined with each other, that is:

```
input (for example): 0123456789012345

result: 
    0123GpLaMjEW
    4567pVOjnnmk
    8901RGiledp6
    2345Mvcezxls
```

It then calculates four md5 hashes from the previously generated strings. To dynamically create the function, it uses the following index array to obtain 4 bytes from each md5 hash, starting at the corresponding position: [8, 2, 7, 1]. In other words, it takes 4 bytes starting at index 8 from the first md5 hash, 4 bytes starting at index 2 from the second, and so on. Then it calls this function and hopes that everything will be fine. This is usually not the case.

To solve the problem, you need to find 4 hashes that will generate a function with the following logic:
1. put the constant `0x7B3DC26F1` into the `rdi` register as a parameter that will later be checked by the `validate` function
2. call a `validate` function whose address the previous function passed to you as a parameter in the `rdi` register
3. the whole thing should be <= 16 bytes long

My first thought was: hey, why do you even need 16 bytes? I can cut the problem in half if I try to find something like

```assembly
    xchg    rdi, rax
    mov     rdi, [rax+0x23]
    jmp     rax
```

which is 8 bytes long. But, unfortunately, there is no solution for this code. And I couldn't find a solution for any other 8-10 byte code I could think of.

Based on the hint the author gave, the correct code should be as follows:

```assembly
      mov   rsi, rdi
      mov   rdi, 0x7B3DC26F1
      call  rsi
      ret
```

which is exactly 16 bytes long and results in the following answer: `D1v1d3AndC0nqu3r`.