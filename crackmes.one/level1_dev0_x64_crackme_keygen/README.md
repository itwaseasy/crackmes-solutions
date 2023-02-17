### x64_crackme_keygen by dev0

Crackme's algorithm is quite simple: it takes each character from a given name, XORs it with some precomputed "key", and then sums the result. The way this "key" is generated is interesting, but a bit fragile from my point of view.

Why is it fragile? Because it doesn't check for any errors related to reading data from `proc`.

To get the "master xor key", the crackme does the following:

- it opens `/proc/self/maps`. More precisely, for some reason it uses the path `/proc/PID/maps`, but anyway
- reads the first 15 bytes from this file
- truncates everything up to the first '-' character it finds there, if any
- and sums all characters

Another interesting observation is how the resulting key is calculated. It seems that there is an error in the algorithm (or a feature, who knows):

```asm
.text:00000000004011AF loc_4011AF:
.text:00000000004011AF                 cmp     byte ptr [rsi], 0
.text:00000000004011B2                 jz      short loc_4011BF
.text:00000000004011B4                 mov     dl, [rsi]
.text:00000000004011B6                 xor     edx, ecx
.text:00000000004011B8                 add     eax, edx
.text:00000000004011BA                 inc     rsi
.text:00000000004011BD                 jmp     short loc_4011AF
```

Or, to put it in words, it loads the current character of the name into `dl`, XORs `edx` with "master key" and sums the result. The problem is that if the previous result of the XOR operation was greater than 0xFF, the remaining result from the upper 24 bits of `edx` will be used.

In any case, to generate a key you need:

- run the crackme
- run this keygen: ``head -1 /proc/`pgrep crack`/maps | cut -d- -f1 | xargs ./keygen``
- enjoy