
# "Bombs Landed" by Hack The Box

This is another example from HTB that implements "decryption" of code at runtime (same as "[Partial Encryption](https://pugachev.io/2024/01/04/partial-encryption-by-hack-the -box/ )"crackme I described earlier). On top of that, it has a classic anti-debugging trick with `ptrace` and cleverly hidden code that took me a while to find. That's the "wtf" moment, you know, that doubles and becomes "WTF" when you finally solve the problem. But, as usual, let's start from the beginning.

The disassembly shows that it starts by checking `argc` and some flags, which are an indication that the process is under the debugger (or strace, or any other tool that uses `ptrace`). If `argc` is less than 3, it will just print a nice "Bad luck, dude" message and exit. If `argc` is greater than 3 and the process is in debug mode, it will follow you down the wrong path, still asking for a password. Do you want to crash the application? Enter "X" as the password.

The "ptrace" check has been moved to the `init` function (`c
__attribute__((constructor))` in gcc), which automatically runs before `main` and sets the appropriate flags. To avoid this, if you still want to debug/trace it, there are at least 3 ways to do it: fix the binary, use the `LD_PRELOAD` trick described by everyone, or use the cool "system tampering" feature that `strace` has:

```bash
$ strace -e inject=ptrace:retval=0 ./BombsLanded 1 2 3 4
```

which causes the `ptrace` syscall to return 0 when called from an application.

If everything was OK, the crackme `mmap` the executable memory and "decrypts" via XOR (of course) the extra code it has. The hidden code is 0x196 bytes long and you can decrypt it in IDA using the following script:

```c
auto i, x;

for (i = get_screen_ea(); i <= get_screen_ea() + 0x196; i = i + 1) {
  x = byte(i);
  patch_byte(i, x ^ 0x63);
}
```

This is where the fun begins. The function looks quite simple, even though it uses XOR-encrypted strings for some reason. Double xor = double protection? Maybe. Basically, it asks you for a password, gets a string from the standard input, and compares it to some predefined constant containing a non-printable character:

```assembly
LOAD:0804929D                 push    0Ah
LOAD:0804929F                 lea     eax, [ebp+password]
LOAD:080492A2                 push    eax
LOAD:080492A3                 lea     eax, [ebp+input]
LOAD:080492A6                 push    eax
LOAD:080492A7                 mov     eax, offset strncmp
LOAD:080492AC                 call    eax ; strncmp
```

What could go wrong, right? No. If you look at the binary's import table, it doesn't have `strncmp`, but for some reason it does contain `dlsym`. And if you check where it was called from, then there's this "wtf" moment: the function is a wrapper that checks the length of the passed parameter `s1` (which is a string with a non-printable character), and if it is NOT equal to 10, then it will directly call the original `strncmp`. Otherwise, it will XOR and compare with `s2`. And that's it: just XOR the "encrypted" password with 0x0A and you'll get the answer.
