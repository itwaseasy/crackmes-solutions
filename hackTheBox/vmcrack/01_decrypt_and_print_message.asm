1d 01 03 18                                       push	ebp
1a 01 03 18 01 03 14                              mov	ebp, esp
35 08 00                                          sub	esp, 0x08
1a 02 03 14 00 00 00 00 00 00 03 00 00 00 00      mov	dword ptr [esp], 0x00                   ; message to decrypt
1a 02 03 14 00 00 04 00 00 00 03 00 00 00 00      mov	dword ptr [esp+0x04], 0x00              ; decryption key
1d 01 03 20                                       push	edi
1d 01 03 1c                                       push	esi
1d 01 03 10                                       push	ebx
0e 01 03 04 01 03 04                              xor	eax, eax
1a 01 03 08 03 ff ff 00 00                        mov	ecx, 0xffff
1a 01 03 20 02 03 18 00 00 f8 ff ff ff            mov	edi, dword ptr [ebp+0xfffffff8]
3e 01                                             repne scasb
0a 01 03 08 03 ff ff 00 00                        sub	ecx, 0xffff
03 01 03 08                                       not	ecx
0e 01 03 0c 01 03 0c                              xor	edx, edx
1a 01 03 1c 01 03 18                              mov	esi, ebp
0a 01 03 1c 03 04 00 00 00                        sub	esi, 0x04
1a 01 03 20 02 03 18 00 00 f8 ff ff ff            mov	edi, dword ptr [ebp+0xfffffff8]
0e 01 03 10 01 03 10                              xor	ebx, ebx
10 01 03 10 03 04 00 00 00                        cmp	ebx, 0x04
25 03 ea ff ff ff                                 jz	0xffffffea
1a 01 01 04 02 01 1c 10 01 00 00 00 00            mov	al, byte ptr [esi+ebx]
01 01 03 10                                       inc	ebx
0e 02 01 20 0c 01 00 00 00 00 01 01 04            xor	byte ptr [edi+edx], al
09 02 01 20 0c 01 00 00 00 00 03 7c 00 00 00      add	byte ptr [edi+edx], 0x7c
01 01 03 0c                                       inc	edx
10 01 03 0c 01 03 08                              cmp	edx, ecx
26 03 b3 ff ff ff                                 jnz	0xffffffb3
1d 01 03 20                                       push	edi
32 03 00 00 00 00                                 call	0x00                                   ; puts() address
34 04 00                                          add	esp, 0x04
1e 01 03 10                                       pop	ebx
1e 01 03 1c                                       pop	esi
1e 01 03 20                                       pop	edi
0e 01 03 04 01 03 04                              xor	eax, eax
34 08 00                                          add	esp, 0x08
1e 01 03 18                                       pop	ebp
33 00 00                                          ret
