
# "Iterative Virus" by Hack The Box

A good pet project for a developer who wants to learn something new is writing a game. I've done this before, but it wasn't fun. The best project was to write a virus: tons of new knowledge, a broken OS, when your creature “infected” something unnecessary (plus the infection algorithm doesn't work correctly), fight an antivirus that easily moves your file to quarantine. Oh, the good old days.

This challenge reminded me of those days: this is literally an old-school virus that infects files correctly! I don't mean this fancy "dropper with a downloader with a rootkit with...", but rather something that finds the file, adds a new section, fixes the entry point, and all the things that viruses were supposed to do in the past. It even has something resembling polymorphic behavior! Pretty cool for a CTF challenge.

Let's start exploring it. First, this is a regular PE64 file:

```bash
$ diec ./HELLO_WORLD_INFECTED_\!\!\!.exe
PE64
    Linker: Microsoft Linker(14.28.30038)
    Compiler: Microsoft Visual C/C++(19.28.30038)[C]
    Tool: Visual Studio(2019 version 16.9-16.10)
``` 
But like a good old-fashioned infected file, it has a strange section that the entry point points to:

```bash
$ objdump -wh ./HELLO_WORLD_INFECTED_\!\!\!.exe | grep ivir
  6 .ivir         00000d80  000000014001c000  000000014001c000  00018400  2**4  CONTENTS, ALLOC, LOAD, READONLY, CODE, DATA

$ objdump -f ./HELLO_WORLD_INFECTED_\!\!\!.exe | grep start
start address 0x000000014001c000
```

The code at the entry point also looks familiar: it first finds the address of the `GetProcAddress` function using the `PEB` technique, and then resolves the addresses of additional functions that will be needed later. Here is a list of their names with IDs that it tries to find:

```
5: ExitProcess
6: CreateFileA
7: GetFileSize
8: CreateFileMappingA
9: MapViewOfFile
0x0C: FindFirstFileA
0x0D: FindNextFileA
0x0E: FindClose
0x0F: CloseHandle
```

Then the fun begins. Crackme will check that the fifth byte next to the entry point (the one that follows the first `jmp` instruction) is `5`. If so, it will call a function that currently appears to be encrypted, otherwise, the code will select and store a 64-bit number that will be used later for decryption. In the current binary, there is an `1` in this byte, so it looks like we need to do something to decrypt the extra code. So let's go with the flow and see what the crackme does next.

The next step the algorithm takes is the actual infection phase. To summarize what it does:

1. Search for files matching the `*.exe` wildcard, starting in the current directory.
2. Map the found file into memory using the `CreateFileMappingA`/`MapViewOfFile` functions.
3. If this file is not an EXE file (the first two bytes must be `MZ`) and `_IMAGE_FILE_HEADER.Machine` is not `0x8664` (AMD64), close it and try to find another victim.
4. To avoid accidentally infecting your entire system, it will only infect the file with `0x53494854` ('SIHT' or 'THIS' if you read the binary directly) in `_IMAGE_FILE_HEADER.Timestamp`.
5. If there is enough space in the binary for a new `_IMAGE_SECTION_HEADER`, it will be added immediately after the previous header. The new section will have the following characteristics: `CNT_CODE | CNT_INITIALIZED_DATA | MEM_EXECUTE | MEM_READ` and will be named `.ivir`.
6. The actual virus code will then be copied into the mapped memory, immediately after the last section (with `FileAlignment` of course). Just in case, when the crackme executes `MapViewOfFile` in the second step, it will already request additional memory for the virus body.

If everything goes well, the crackme will move to the encrypted part. It will "decrypt" it again using the key chosen based on the fifth byte I described earlier. So, given that the binary we have has a `1` at this location, the key `1` will be used and the magic byte will be updated. In other words, every time it infects the files it finds, it will use the `current_byte_value` key and update the byte accordingly. This means that if you run a newly infected file, it will use the `2` key and so on. If there is a `5` in that magic byte of the file, nothing will be done, which simply means that the code has finally been decrypted.

You could definitely play around with this and create specially crafted infection files to get the decrypted code back, but I cut corners and used the following IDC script:

```c
auto keys = object();
keys[0] = 0x28C8AA0746A75909;
keys[1] = 0x6E2368B9C685770B;
keys[2] = 0x0EB7FD64E061C1A3D;
keys[3] = 0x0CB8FF2D53D7505A1;
keys[4] = 0x0F1EF554206DCE4D;

auto i, j;

for (i = 1; i < 5; ++i) {
	for (j = get_screen_ea(); j <= get_screen_ea() + 0x198; j = j + 8) {
		x = get_qword(j);
		patch_qword(j, x * keys[i]);
	}
}
```

As you can see, the decryption algorithm is just a multiplication. So, if you apply it 4 times (because the author has already done it once), using the correct constants, you will get the code back. Nice!

The decrypted code is simple: it will show you a message box with a flag if the username running the binary matches the flag :) So you'll have to disassemble it anyway. Additionally, since the code is executed as part of the infection phase, it also dynamically resolves the required function using the same idea as the main code.

One final note: the virus kindly stores the original entry point of the infected file in the qword following the magic byte. The only thing is that this is not an absolute RVA, but the difference between the new and previous entry point. Feel free to write an antivirus.

The challenge can be found [here](https://app.hackthebox.com/challenges/Iterative%2520Virus).
