1d 01 03 18                                       push	ebp
1a 01 03 18 01 03 14                              mov	ebp, esp
35 0c 00                                          sub	esp, 0x0c
1a 02 03 14 00 00 00 00 00 00 03 00 00 00 00      mov	dword ptr [esp], 0x00                   ; user_input
1a 02 03 14 00 00 04 00 00 00 03 00 00 00 00      mov	dword ptr [esp+0x04], 0x00              ; binary_blob
1a 02 03 14 00 00 08 00 00 00 03 00 00 00 00      mov	dword ptr [esp+0x08], 0x00              ; 0x570h - binary_blob size
1d 01 03 20                                       push	edi
1d 01 03 1c                                       push	esi
1d 01 03 10                                       push	ebx
0e 01 03 04 01 03 04                              xor	eax, eax
1a 01 03 08 03 ff ff 00 00                        mov	ecx, 0xffff
1a 01 03 20 02 03 18 00 00 f4 ff ff ff            mov	edi, dword ptr [ebp+0xfffffff4]         ; user_input
3e 01                                             repne scasb
0a 01 03 08 03 ff ff 00 00                        sub	ecx, 0xffff
03 01 03 08                                       not	ecx
1a 01 03 10 01 03 08                              mov	ebx, ecx
35 10 00                                          sub	esp, 0x10
1a 01 03 1c 01 03 14                              mov	esi, esp
1d 01 03 1c                                       push	esi
1d 01 03 10                                       push	ebx
1d 02 03 18 00 00 f4 ff ff ff                     push	dword ptr [ebp+0xfffffff4]              ; user_input
32 03 00 00 00 00                                 call	0x00                                    ; calculate_MD5
34 0c 00                                          add	esp, 0x0c
35 20 00                                          sub	esp, 0x20
1a 01 03 20 01 03 14                              mov	edi, esp
1d 01 03 20                                       push	edi
1d 01 03 10                                       push	ebx
1d 02 03 18 00 00 f4 ff ff ff                     push	dword ptr [ebp+0xfffffff4]              ; user_input
32 03 00 00 00 00                                 call	0x00                                    ; calculate_SHA256
34 0c 00                                          add	esp, 0x0c
1d 01 03 1c                                       push	esi                                     ; MD5 hash
1d 01 03 20                                       push	edi                                     ; SHA256 hash
1d 02 03 18 00 00 fc ff ff ff                     push	dword ptr [ebp+0xfffffffc]              ; binary_blob size
1d 02 03 18 00 00 f8 ff ff ff                     push	dword ptr [ebp+0xfffffff8]              ; binary_blob
32 03 00 00 00 00                                 call	0x00                                    ; decrypt_AES
34 40 00                                          add	esp, 0x40
1d 02 03 18 00 00 fc ff ff ff                     push	dword ptr [ebp+0xfffffffc]              ; binary_blob size
1d 02 03 18 00 00 f8 ff ff ff                     push	dword ptr [ebp+0xfffffff8]              ; binary_blob
32 03 00 00 00 00                                 call	0x00                                    ; calculate_CRC32
34 08 00                                          add	esp, 0x08
1a 01 03 10 01 03 04                              mov	ebx, eax
0e 01 03 04 01 03 04                              xor	eax, eax
10 01 03 10 03 f6 c9 a2 4d                        cmp	ebx, 0x4da2c9f6
26 03 09 00 00 00                                 jnz	0x09                                    ; wrong
1a 01 03 04 03 01 00 00 00                        mov	eax, 0x01

wrong:
1e 01 03 10                                       pop	ebx
1e 01 03 1c                                       pop	esi
1e 01 03 20                                       pop	edi
34 0c 00                                          add	esp, 0x0c
1e 01 03 18                                       pop	ebp
33 00 00                                          ret
