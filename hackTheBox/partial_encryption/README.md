
# "Partial Encryption" by Hack The Box

This is the first crackme I've solved that decrypts and executes code at runtime, so I think my solution is not very optimal. But hey, the point is to learn new things, right?

The crackme consists of four function calls that perform the main logic:
- checks the number of command line arguments (a flag must be passed as an argument)
- checks the length of the flag
- checks the flag
- prints the result based on the previous step

The problem is that the real code is hidden, i.e. each of these functions deciphers the code it needs at runtime and passes execution there. Depending on the steps, each `decrypted_func` takes different arguments, but typically it looks like this:

```c
typedef void (*decrypted_func)(putchar_ptr, exit_ptr, int argc, char** argv);

decrypted_func f = decryptCode(sub_7FF629A64000, 112);
f(putchar_ptr, exit_ptr, argc, argv);
```

Thus, the `decryptCode` function takes a pointer to static binary data and length, internally allocates memory, decrypts the data, and returns a pointer to the decrypted opcodes.

The decryption logic itself is quite clear: it processes the data in blocks of 16 bytes, generates a "key" based on the block index, and then XORs the real data. The only challenge is that it uses SSE2 and AES instructions, so it was a completely new experience for me, but definitely an interesting one. Just in case, an [excellent guide](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html) on intrinsic functions from Intel makes life much easier.

To parse the decrypted code in IDA, I used a small IDC script that helped me get the plaintext (clearcode?) back into the database:

```c
static dump_decrypted_mem(from, to, size) {
    auto i, x;
    for (i = 0; i < size; i = i + 1) {
        x = byte(from);
        patch_byte(to, x);
        to = to + 1;
        from = from + 1;
    }
}
```

This way I can run it directly from the IDA console during a debugging session and dump the decrypted data back to the same address that was used in the `decryptCode` function as the source buffer.

As I said at the beginning, there are more elegant ways to do this. It would probably be better to set a conditional breakpoint that runs this IDC function for each processed block in the decryption loop, but whatever.

The decrypted code is trivial as it simply compares the flag character by character to the hard-coded data, so to find the answer you just need to read it directly when disassembling it.
