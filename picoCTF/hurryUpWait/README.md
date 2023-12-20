# "Hurry up! Wait!" by picoCTF

This crackme is written in Ada, which in itself is quite fun experience. You can guess the language from several signs that are in the file: `___gnat_initialize` and `___gnat_finalize` function calls in `main`, `_ada_main` and a lot of other strings like `ada__*` that IDA can find in the binary. Until this moment I had never encountered the Ada language in my life, so this GNAT  library told me nothing. Thanks to this crackme, I now know that it stands for "The GNU Ada Development Environment" and it's one of the main implementations of the language.

Anyway, as I said, crackme's logic is easy once you get used to the nature of the GNAT library and the Ada standard library. In total, it calls different functions 27 times, each printing one character, using the `Ada.Text_IO.Put` library function. And to avoid printing the flag right away, it calls the `Ada.Calendar.Delays.Delay_For` function before setting the delay to `1'000'000'000'000'000` seconds,  which is a little over `31'709'791` years, if I calculated correctly. So yeah, no need to rush, just wait.

To get the flag, you either need to go through all 27 functions and carefully write down on a napkin the characters they will print (which is what I did), or patch the binary, or adjust the duration during a debugging session. As an exercise, I also patched the binary and got the following:

```bash
$ # this is the Duration parameter for the Ada.Calendar.Delays.Delay_For function
$ dd status=none if=./svchost.exe count=10 bs=1 skip=$((0x298e)) | ndisasm -b64 -
00000000  48BF0080C6A47E8D  mov rdi,0x38d7ea4c68000

$ # let's set it to 1
$ printf '\x01\x00\x00\x00\x00\x00\x00' | dd status=none conv=notrunc of=svchost.exe bs=1 seek=$((0x2990))

$ # this is what we have after the patch
$ dd status=none if=./svchost.exe count=10 bs=1 skip=$((0x298e)) | ndisasm -b64 -
00000000  48BF010000000000  mov rdi,0x1

$ # and the flag is...
$  ./svchost.exe
picoCTF{d15a5m_ftw_5c1d1ae}
```
