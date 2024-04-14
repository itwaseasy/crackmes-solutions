1d 01 03 18                                       push	ebp
1a 01 03 18 01 03 14                              mov	ebp, esp
1d 03 01 00 00 00                                 push	0x01
32 03 00 00 00 00                                 call	0x00                ; exit() address
34 04 00                                          add	esp, 0x04
0e 01 03 04 01 03 04                              xor	eax, eax
1a 01 03 14 01 03 18                              mov	esp, ebp
1e 01 03 18                                       pop	ebp
33 00 00                                          ret
