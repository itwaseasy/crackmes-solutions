31 03 0a 00 00 00                                 jmp	0x0a                                ; jmp start

exit:
0e 01 03 04 01 03 04                              xor	eax, eax
33 00 00                                          ret

start:
1b 01 03 08 03 30 00 00 00                        mov	ecx, fs:0x30                        ; PEB
1a 01 03 04 02 01 08 00 00 02 00 00 00            mov	eax, byte ptr [ecx+0x02]            ; BeingDebugged
11 01 03 04 01 03 04                              test	eax, eax
26 03 d3 ff ff ff                                 jnz	0xffffffd3                          ; jnz exit
1a 01 03 04 02 03 08 00 00 68 00 00 00            mov	eax, dword ptr [ecx+0x68]           ; NtGlobalFlag
0f 01 03 04 03 70 00 00 00                        and	eax, 0x70
10 01 03 04 03 70 00 00 00                        cmp	eax, 0x70                           ; 0x70 -> being debugged, see https://unprotect.it/technique/ntglobalflag/
25 03 ae ff ff ff                                 jz	0xffffffae                          ; jz exit
1a 01 03 0c 02 03 08 00 00 18 00 00 00            mov	edx, dword ptr [ecx+0x18]           ; ProcessHeap
1a 01 03 04 02 03 0c 00 00 40 00 00 00            mov	eax, dword ptr [edx+0x40]           ; ProcessHeap.Flags
11 01 03 04 03 02 00 00 00                        test	eax, 0x02                           ; 0x02 -> being debugged, see https://unprotect.it/technique/heap-flag/
25 03 85 ff ff ff                                 jz	0xffffff85                          ; jz exit
1a 01 03 04 02 03 0c 00 00 44 00 00 00            mov	eax, dword ptr [edx+0x44]           ; ProcessHeap.dwHeapForceFlagsOffset
11 01 03 04 01 03 04                              test	eax, eax                            ; != 0 -> being debugged
26 03 6b ff ff ff                                 jnz	0xffffff6b                          ; jnz exit
1c 01 03 08 03 60 00 00 00                        mov_wtf	ecx, 0x60                       ; The instruction emulates a neat trick that switches to 64-bit mode, gets PEB64 and returns back
                                                                                            ; more info here: http://blog.rewolf.pl/blog/?p=102
1a 01 03 04 02 01 08 00 00 02 00 00 00            mov	eax, byte ptr [ecx+0x02]            ; BeingDebugged
11 01 03 04 01 03 04                              test	eax, eax
26 03 48 ff ff ff                                 jnz	0xffffff48                          ; jnz exit
1a 01 03 04 02 03 08 00 00 bc 00 00 00            mov	eax, dword ptr [ecx+0xbc]           ; NtGlobalFlag
0f 01 03 04 03 70 00 00 00                        and	eax, 0x70
10 01 03 04 03 70 00 00 00                        cmp	eax, 0x70
25 03 23 ff ff ff                                 jz	0xffffff23                          ; jz exit
1a 01 03 0c 02 03 08 00 00 30 00 00 00            mov	edx, dword ptr [ecx+0x30]           ; ProcessHeap
1a 01 03 04 02 03 0c 00 00 70 00 00 00            mov	eax, dword ptr [edx+0x70]           ; ProcessHeap.Flags
11 01 03 04 03 02 00 00 00                        test	eax, 0x02
25 03 fa fe ff ff                                 jz	0xfffffefa                          ; jz exit
1a 01 03 04 02 03 0c 00 00 74 00 00 00            mov	eax, dword ptr [edx+0x74]           ; ProcessHeap.HeapForceFlags
11 01 03 04 01 03 04                              test	eax, eax
26 03 e0 fe ff ff                                 jnz	0xfffffee0                          ; jnz exit
1d 01 03 1c                                       push	esi
1d 01 03 20                                       push	edi
1d 03 00 00 00 00                                 push	0x00
1a 01 03 04 01 03 14                              mov	eax, esp
1d 03 6d 66 75 6f                                 push	0x6f75666d                          ; [Human.IO]::Translate("Credentials por favor"):
1d 03 2e 39 20 3d                                 push	0x3d20392e
1d 03 20 3d 6f 29                                 push	0x296f3d20
1d 03 23 3c 6f 3f                                 push	0x3f6f3c23
1d 03 21 3b 26 2e                                 push	0x2e263b21
1d 03 3d 2a 2b 2a                                 push	0x2a2b2a3d
1d 03 2a 67 6d 0c                                 push	0xc6d672a
1d 03 3c 23 2e 3b                                 push	0x3b2e233c
1d 03 1b 3d 2e 21                                 push	0x212e3d1b
1d 03 00 12 75 75                                 push	0x75751200
1d 03 2e 21 61 06                                 push	0x661212e
1d 03 14 07 3a 22                                 push	0x223a0714
1a 01 03 08 01 03 04                              mov	ecx, eax
0a 01 03 08 01 03 14                              sub	ecx, esp

xor_loop:
0e 02 01 14 08 01 ff ff ff ff 03 4f 00 00 00      xor	byte ptr [esp+ecx+0xffffffff], 0x4f
02 01 03 08                                       dec	ecx
26 03 e7 ff ff ff                                 jnz	0xffffffe7                          ; jnz xor_loop
1a 01 03 04 01 03 14                              mov	eax, esp
1d 03 00 00 00 00                                 push	0x00                                ; push stdout
1d 01 03 04                                       push	eax
32 03 00 00 00 00                                 call	0x00                                ; call fputs
34 3c 00                                          add	esp, 0x3c
35 00 01                                          sub	esp, 0x100
1a 01 03 04 01 03 14                              mov	eax, esp
1d 03 00 00 00 00                                 push	0x00                                ; push stdin
1d 03 00 01 00 00                                 push	0x100
1d 01 03 04                                       push	eax
32 03 00 00 00 00                                 call	0x00                                ; call fgets
34 0c 00                                          add	esp, 0x0c
0e 01 03 04 01 03 04                              xor	eax, eax
1a 01 03 08 03 ff ff 00 00                        mov	ecx, 0xffff
1a 01 03 20 01 03 14                              mov	edi, esp
3e 01                                             repne scasb
0a 01 03 08 03 ff ff 00 00                        sub	ecx, 0xffff
03 01 03 08                                       not	ecx
02 01 03 08                                       dec	ecx
1a 02 01 14 08 01 00 00 00 00 03 00 00 00 00      mov	byte ptr [esp+ecx], 0x00
1a 01 03 0c 01 03 08                              mov	edx, ecx
1a 01 03 1c 01 03 14                              mov	esi, esp
1a 01 03 20 03 00 00 00 00                        mov	edi, 0x00                           ; mov edi, array_256_bytes
37 01                                             rep movsb
1a 01 03 08 01 03 0c                              mov	ecx, edx
31 03 17 00 00 00                                 jmp	0x17                                ; jmp check_length

incorrect:
1a 01 03 04 03 01 00 00 00                        mov	eax, 0x01

correct:
34 00 01                                          add	esp, 0x100
1e 01 03 20                                       pop	edi
1e 01 03 1c                                       pop	esi
33 00 00                                          ret

check_length:
10 01 03 0c 03 3b 00 00 00                        cmp	edx, 0x3b
26 03 da ff ff ff                                 jnz	0xffffffda                          ; jnz incorrect

decrypt:
1a 01 03 04 02 01 14 08 01 00 00 00 00            mov	eax, byte ptr [esp+ecx]
01 02 01 14 08 01 ff ff ff ff                     inc	byte ptr [esp+ecx+0xffffffff]
16 02 01 14 08 01 ff ff ff ff 03 9f 00 00 00      rol	byte ptr [esp+ecx+0xffffffff], 0x9f
0a 02 01 14 08 01 ff ff ff ff 03 0e 00 00 00      sub	byte ptr [esp+ecx+0xffffffff], 0x0e
03 02 01 14 08 01 ff ff ff ff                     not	byte ptr [esp+ecx+0xffffffff]
0e 02 01 14 08 01 ff ff ff ff 03 c3 00 00 00      xor	byte ptr [esp+ecx+0xffffffff], 0xc3
04 02 01 14 08 01 ff ff ff ff                     neg	byte ptr [esp+ecx+0xffffffff]
09 02 01 14 08 01 ff ff ff ff 03 3e 00 00 00      add	byte ptr [esp+ecx+0xffffffff], 0x3e
17 02 01 14 08 01 ff ff ff ff 03 1d 00 00 00      ror	byte ptr [esp+ecx+0xffffffff], 0x1d
02 02 01 14 08 01 ff ff ff ff                     dec	byte ptr [esp+ecx+0xffffffff]
0e 02 01 14 08 01 ff ff ff ff 01 01 04            xor	byte ptr [esp+ecx+0xffffffff], al
02 01 03 08                                       dec	ecx
26 03 69 ff ff ff                                 jnz	0xffffff69                          ; jnz decrypt

1a 01 03 20 01 03 14                              mov	edi, esp
1d 03 f5 ed 17 00                                 push	0x17edf5                            ; Correct (and encrypted) input
1d 03 f5 ed f5 ed                                 push	0xedf5edf5
1d 03 fe d6 d5 a5                                 push	0xa5d5d6fe
1d 03 fe d6 fe d6                                 push	0xd6fed6fe
1d 03 66 91 c1 c2                                 push	0xc2c19166
1d 03 6e 06 32 5a                                 push	0x5a32066e
1d 03 2d 69 29 6d                                 push	0x6d29692d
1d 03 36 72 6a 2e                                 push	0x2e6a7236
1d 03 65 35 09 35                                 push	0x35093565
1d 03 7b 53 70 8a                                 push	0x8a70537b
1d 03 dc ac f8 0f                                 push	0xff8acdc
1d 03 a8 5b 67 90                                 push	0x90675ba8
1d 03 1f a0 a8 f3                                 push	0xf3a8a01f
1d 03 a7 8f c3 88                                 push	0x88c38fa7
1d 03 8c 9c eb bf                                 push	0xbfeb9c8c
1a 01 03 1c 01 03 14                              mov	esi, esp
1a 01 03 08 01 03 0c                              mov	ecx, edx
39 01                                             repe cmpsb
34 3c 00                                          add	esp, 0x3c
26 03 c9 fe ff ff                                 jnz	0xfffffec9                          ; jnz incorrect
1a 01 03 04 03 02 00 00 00                        mov	eax, 0x02
31 03 c3 fe ff                                    jmp	0xfffec3                            ; jmp correct
