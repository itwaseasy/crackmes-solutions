Index	Opcode	Disasm
0000	817500	push 0075           	
0003	8000  	push 0000           	
0005	800a  	push 000A           	
0007	803f  	push 003F           	
0009	8065  	push 0065           	
000B	8076  	push 0076           	
000D	8069  	push 0069           	
000F	806c  	push 006C           	
0011	8061  	push 0061           	
0013	8020  	push 0020           	
0015	8074  	push 0074           	
0017	8075  	push 0075           	
0019	806f  	push 006F           	
001B	8020  	push 0020           	
001D	8074  	push 0074           	
001F	8069  	push 0069           	
0021	8020  	push 0020           	
0023	8065  	push 0065           	
0025	806b  	push 006B           	
0027	8061  	push 0061           	
0029	806d  	push 006D           	
002B	8020  	push 0020           	
002D	8075  	push 0075           	
002F	806f  	push 006F           	
0031	8079  	push 0079           	
0033	8020  	push 0020           	
0035	806e  	push 006E           	
0037	8061  	push 0061           	
0039	8043  	push 0043           	
003B	800a  	push 000A           	
003D	8058  	push 0058           	
003F	8020  	push 0020           	
0041	8049  	push 0049           	
0043	8020  	push 0020           	
0045	8052  	push 0052           	
0047	8020  	push 0020           	
0049	8054  	push 0054           	
004B	8020  	push 0020           	
004D	8041  	push 0041           	
004F	8020  	push 0020           	
0051	804d  	push 004D           	
0053	8020  	push 0020           	
0055	8065  	push 0065           	
0057	8068  	push 0068           	
0059	8074  	push 0074           	
005B	8020  	push 0020           	
005D	806f  	push 006F           	
005F	8074  	push 0074           	
0061	8020  	push 0020           	
0063	8065  	push 0065           	
0065	806d  	push 006D           	
0067	806f  	push 006F           	
0069	8063  	push 0063           	
006B	806c  	push 006C           	
006D	8065  	push 0065           	
006F	8057  	push 0057           	
0071	813b01	push 013B           	
0074	30    	pop r1              	
				jmp r1
0075	8001  	push 0001           	
0077	8001  	push 0001           	
0079	8000  	push 0000           	
007B	C0    	call getc           	
				push r1
007C	10    	push [sp-2]         	
007D	8075  	push 0075           	
007F	13    	pop r1              	
				sub [sp-2], r1
0080	81a000	push 00A0           	
0083	31    	pop r1              	
				pop r2
				test r2, r2
				jnz 0084
				jmp r1
0084	10    	push [sp-2]         	
0085	8064  	push 0064           	
0087	13    	pop r1              	
				sub [sp-2], r1
0088	81aa00	push 00AA           	
008B	31    	pop r1              	
				pop r2
				test r2, r2
				jnz 008C
				jmp r1
008C	10    	push [sp-2]         	
008D	806c  	push 006C           	
008F	13    	pop r1              	
				sub [sp-2], r1
0090	81b400	push 00B4           	
0093	31    	pop r1              	
				pop r2
				test r2, r2
				jnz 0094
				jmp r1
0094	10    	push [sp-2]         	
0095	8072  	push 0072           	
0097	13    	pop r1              	
				sub [sp-2], r1
0098	81c000	push 00C0           	
009B	31    	pop r1              	
				pop r2
				test r2, r2
				jnz 009C
				jmp r1
009C	81fb00	push 00FB           	
009F	30    	pop r1              	
				jmp r1
00A0	11    	pop r1              	
00A1	20    	pop r1              	
				push_e r1
00A2	8001  	push 0001           	
00A4	13    	pop r1              	
				sub [sp-2], r1
00A5	21    	pop_e r1            	
				push r1
00A6	81cc00	push 00CC           	
00A9	30    	pop r1              	
				jmp r1
00AA	11    	pop r1              	
00AB	20    	pop r1              	
				push_e r1
00AC	8001  	push 0001           	
00AE	12    	pop r1              	
				add [sp-2], r1
00AF	21    	pop_e r1            	
				push r1
00B0	81cc00	push 00CC           	
00B3	30    	pop r1              	
				jmp r1
00B4	11    	pop r1              	
00B5	20    	pop r1              	
				push_e r1
00B6	20    	pop r1              	
				push_e r1
00B7	8001  	push 0001           	
00B9	13    	pop r1              	
				sub [sp-2], r1
00BA	21    	pop_e r1            	
				push r1
00BB	21    	pop_e r1            	
				push r1
00BC	81cc00	push 00CC           	
00BF	30    	pop r1              	
				jmp r1
00C0	11    	pop r1              	
00C1	20    	pop r1              	
				push_e r1
00C2	20    	pop r1              	
				push_e r1
00C3	8001  	push 0001           	
00C5	12    	pop r1              	
				add [sp-2], r1
00C6	21    	pop_e r1            	
				push r1
00C7	21    	pop_e r1            	
				push r1
00C8	81cc00	push 00CC           	
00CB	30    	pop r1              	
				jmp r1
00CC	20    	pop r1              	
				push_e r1
00CD	20    	pop r1              	
				push_e r1
00CE	81da00	push 00DA           	
00D1	21    	pop_e r1            	
				push r1
00D2	10    	push [sp-2]         	
00D3	20    	pop r1              	
				push_e r1
00D4	8010  	push 0010           	
00D6	814701	push 0147           	
00D9	30    	pop r1              	
				jmp r1
00DA	14    	xchg [sp-4], [sp-2] 	
00DB	10    	push [sp-2]         	
00DC	20    	pop r1              	
				push_e r1
00DD	12    	pop r1              	
				add [sp-2], r1
00DE	21    	pop_e r1            	
				push r1
00DF	14    	xchg [sp-4], [sp-2] 	
00E0	21    	pop_e r1            	
				push r1
00E1	14    	xchg [sp-4], [sp-2] 	
00E2	21    	pop_e r1            	
				push r1
00E3	14    	xchg [sp-4], [sp-2] 	
00E4	20    	pop r1              	
				push_e r1
00E5	81ef00	push 00EF           	
00E8	21    	pop_e r1            	
				push r1
00E9	8002  	push 0002           	
00EB	816101	push 0161           	
00EE	30    	pop r1              	
				jmp r1
00EF	817b00	push 007B           	
00F2	14    	xchg [sp-4], [sp-2] 	
00F3	817401	push 0174           	
00F6	12    	pop r1              	
				add [sp-2], r1
00F7	30    	pop r1              	
				jmp r1
00F8	8000  	push 0000           	
00FA	01    	pop r1              	
				ret
00FB	813801	push 0138           	
00FE	8000  	push 0000           	
0100	800a  	push 000A           	
0102	802e  	push 002E           	
0104	8065  	push 0065           	
0106	8075  	push 0075           	
0108	8072  	push 0072           	
010A	8067  	push 0067           	
010C	8020  	push 0020           	
010E	8061  	push 0061           	
0110	8020  	push 0020           	
0112	8079  	push 0079           	
0114	8062  	push 0062           	
0116	8020  	push 0020           	
0118	806e  	push 006E           	
011A	8065  	push 0065           	
011C	8074  	push 0074           	
011E	8061  	push 0061           	
0120	8065  	push 0065           	
0122	8020  	push 0020           	
0124	8065  	push 0065           	
0126	8072  	push 0072           	
0128	8065  	push 0065           	
012A	8077  	push 0077           	
012C	8020  	push 0020           	
012E	8075  	push 0075           	
0130	806f  	push 006F           	
0132	8059  	push 0059           	
0134	813b01	push 013B           	
0137	30    	pop r1              	
				jmp r1
0138	8001  	push 0001           	
013A	01    	pop r1              	
				ret
013B	10    	push [sp-2]         	
013C	814501	push 0145           	
013F	31    	pop r1              	
				pop r2
				test r2, r2
				jnz 0140
				jmp r1
0140	C1    	pop r1              	
				call putc
0141	813b01	push 013B           	
0144	30    	pop r1              	
				jmp r1
0145	11    	pop r1              	
0146	30    	pop r1              	
				jmp r1
0147	8000  	push 0000           	
0149	20    	pop r1              	
				push_e r1
014A	20    	pop r1              	
				push_e r1
014B	10    	push [sp-2]         	
014C	815b01	push 015B           	
014F	31    	pop r1              	
				pop r2
				test r2, r2
				jnz 0150
				jmp r1
0150	8001  	push 0001           	
0152	13    	pop r1              	
				sub [sp-2], r1
0153	21    	pop_e r1            	
				push r1
0154	10    	push [sp-2]         	
0155	21    	pop_e r1            	
				push r1
0156	12    	pop r1              	
				add [sp-2], r1
0157	814901	push 0149           	
015A	30    	pop r1              	
				jmp r1
015B	11    	pop r1              	
015C	21    	pop_e r1            	
				push r1
015D	11    	pop r1              	
015E	21    	pop_e r1            	
				push r1
015F	14    	xchg [sp-4], [sp-2] 	
0160	30    	pop r1              	
				jmp r1
0161	10    	push [sp-2]         	
0162	817101	push 0171           	
0165	31    	pop r1              	
				pop r2
				test r2, r2
				jnz 0166
				jmp r1
0166	8001  	push 0001           	
0168	13    	pop r1              	
				sub [sp-2], r1
0169	20    	pop r1              	
				push_e r1
016A	10    	push [sp-2]         	
016B	12    	pop r1              	
				add [sp-2], r1
016C	21    	pop_e r1            	
				push r1
016D	816101	push 0161           	
0170	30    	pop r1              	
				jmp r1
0171	11    	pop r1              	
0172	14    	xchg [sp-4], [sp-2] 	
0173	30    	pop r1              	
				jmp r1
0174	81fb00	push 00FB           	
0177	30    	pop r1              	
				jmp r1
0178	81fb00	push 00FB           	
017B	30    	pop r1              	
				jmp r1
017C	81fb00	push 00FB           	
017F	30    	pop r1              	
				jmp r1
0180	81fb00	push 00FB           	
0183	30    	pop r1              	
				jmp r1
0184	81fb00	push 00FB           	
0187	30    	pop r1              	
				jmp r1
0188	81fb00	push 00FB           	
018B	30    	pop r1              	
				jmp r1
018C	81fb00	push 00FB           	
018F	30    	pop r1              	
				jmp r1
0190	81fb00	push 00FB           	
0193	30    	pop r1              	
				jmp r1
0194	81fb00	push 00FB           	
0197	30    	pop r1              	
				jmp r1
0198	81fb00	push 00FB           	
019B	30    	pop r1              	
				jmp r1
019C	81fb00	push 00FB           	
019F	30    	pop r1              	
				jmp r1
01A0	81fb00	push 00FB           	
01A3	30    	pop r1              	
				jmp r1
01A4	81fb00	push 00FB           	
01A7	30    	pop r1              	
				jmp r1
01A8	81fb00	push 00FB           	
01AB	30    	pop r1              	
				jmp r1
01AC	81fb00	push 00FB           	
01AF	30    	pop r1              	
				jmp r1
01B0	81fb00	push 00FB           	
01B3	30    	pop r1              	
				jmp r1
01B4	81fb00	push 00FB           	
01B7	30    	pop r1              	
				jmp r1
01B8	30    	pop r1              	
				jmp r1
01B9	00    	nop                 	
01BA	00    	nop                 	
01BB	00    	nop                 	
01BC	30    	pop r1              	
				jmp r1
01BD	00    	nop                 	
01BE	00    	nop                 	
01BF	00    	nop                 	
01C0	30    	pop r1              	
				jmp r1
01C1	00    	nop                 	
01C2	00    	nop                 	
01C3	00    	nop                 	
01C4	30    	pop r1              	
				jmp r1
01C5	00    	nop                 	
01C6	00    	nop                 	
01C7	00    	nop                 	
01C8	30    	pop r1              	
				jmp r1
01C9	00    	nop                 	
01CA	00    	nop                 	
01CB	00    	nop                 	
01CC	817f05	push 057F           	
01CF	30    	pop r1              	
				jmp r1
01D0	81fb00	push 00FB           	
01D3	30    	pop r1              	
				jmp r1
01D4	30    	pop r1              	
				jmp r1
01D5	00    	nop                 	
01D6	00    	nop                 	
01D7	00    	nop                 	
01D8	81fb00	push 00FB           	
01DB	30    	pop r1              	
				jmp r1
01DC	817f05	push 057F           	
01DF	30    	pop r1              	
				jmp r1
01E0	30    	pop r1              	
				jmp r1
01E1	00    	nop                 	
01E2	00    	nop                 	
01E3	00    	nop                 	
01E4	30    	pop r1              	
				jmp r1
01E5	00    	nop                 	
01E6	00    	nop                 	
01E7	00    	nop                 	
01E8	81fb00	push 00FB           	
01EB	30    	pop r1              	
				jmp r1
01EC	30    	pop r1              	
				jmp r1
01ED	00    	nop                 	
01EE	00    	nop                 	
01EF	00    	nop                 	
01F0	81fb00	push 00FB           	
01F3	30    	pop r1              	
				jmp r1
01F4	81fb00	push 00FB           	
01F7	30    	pop r1              	
				jmp r1
01F8	81fb00	push 00FB           	
01FB	30    	pop r1              	
				jmp r1
01FC	81fb00	push 00FB           	
01FF	30    	pop r1              	
				jmp r1
0200	81fb00	push 00FB           	
0203	30    	pop r1              	
				jmp r1
0204	817405	push 0574           	
0207	30    	pop r1              	
				jmp r1
0208	81fb00	push 00FB           	
020B	30    	pop r1              	
				jmp r1
020C	81fb00	push 00FB           	
020F	30    	pop r1              	
				jmp r1
0210	81fb00	push 00FB           	
0213	30    	pop r1              	
				jmp r1
0214	30    	pop r1              	
				jmp r1
0215	00    	nop                 	
0216	00    	nop                 	
0217	00    	nop                 	
0218	81fb00	push 00FB           	
021B	30    	pop r1              	
				jmp r1
021C	81fb00	push 00FB           	
021F	30    	pop r1              	
				jmp r1
0220	81fb00	push 00FB           	
0223	30    	pop r1              	
				jmp r1
0224	30    	pop r1              	
				jmp r1
0225	00    	nop                 	
0226	00    	nop                 	
0227	00    	nop                 	
0228	81fb00	push 00FB           	
022B	30    	pop r1              	
				jmp r1
022C	30    	pop r1              	
				jmp r1
022D	00    	nop                 	
022E	00    	nop                 	
022F	00    	nop                 	
0230	81fb00	push 00FB           	
0233	30    	pop r1              	
				jmp r1
0234	81fb00	push 00FB           	
0237	30    	pop r1              	
				jmp r1
0238	30    	pop r1              	
				jmp r1
0239	00    	nop                 	
023A	00    	nop                 	
023B	00    	nop                 	
023C	30    	pop r1              	
				jmp r1
023D	00    	nop                 	
023E	00    	nop                 	
023F	00    	nop                 	
0240	30    	pop r1              	
				jmp r1
0241	00    	nop                 	
0242	00    	nop                 	
0243	00    	nop                 	
0244	30    	pop r1              	
				jmp r1
0245	00    	nop                 	
0246	00    	nop                 	
0247	00    	nop                 	
0248	30    	pop r1              	
				jmp r1
0249	00    	nop                 	
024A	00    	nop                 	
024B	00    	nop                 	
024C	30    	pop r1              	
				jmp r1
024D	00    	nop                 	
024E	00    	nop                 	
024F	00    	nop                 	
0250	30    	pop r1              	
				jmp r1
0251	00    	nop                 	
0252	00    	nop                 	
0253	00    	nop                 	
0254	30    	pop r1              	
				jmp r1
0255	00    	nop                 	
0256	00    	nop                 	
0257	00    	nop                 	
0258	30    	pop r1              	
				jmp r1
0259	00    	nop                 	
025A	00    	nop                 	
025B	00    	nop                 	
025C	30    	pop r1              	
				jmp r1
025D	00    	nop                 	
025E	00    	nop                 	
025F	00    	nop                 	
0260	81fb00	push 00FB           	
0263	30    	pop r1              	
				jmp r1
0264	30    	pop r1              	
				jmp r1
0265	00    	nop                 	
0266	00    	nop                 	
0267	00    	nop                 	
0268	81fb00	push 00FB           	
026B	30    	pop r1              	
				jmp r1
026C	30    	pop r1              	
				jmp r1
026D	00    	nop                 	
026E	00    	nop                 	
026F	00    	nop                 	
0270	81fb00	push 00FB           	
0273	30    	pop r1              	
				jmp r1
0274	81fb00	push 00FB           	
0277	30    	pop r1              	
				jmp r1
0278	81fb00	push 00FB           	
027B	30    	pop r1              	
				jmp r1
027C	30    	pop r1              	
				jmp r1
027D	00    	nop                 	
027E	00    	nop                 	
027F	00    	nop                 	
0280	81fb00	push 00FB           	
0283	30    	pop r1              	
				jmp r1
0284	30    	pop r1              	
				jmp r1
0285	00    	nop                 	
0286	00    	nop                 	
0287	00    	nop                 	
0288	81fb00	push 00FB           	
028B	30    	pop r1              	
				jmp r1
028C	81fb00	push 00FB           	
028F	30    	pop r1              	
				jmp r1
0290	81fb00	push 00FB           	
0293	30    	pop r1              	
				jmp r1
0294	81fb00	push 00FB           	
0297	30    	pop r1              	
				jmp r1
0298	81fb00	push 00FB           	
029B	30    	pop r1              	
				jmp r1
029C	30    	pop r1              	
				jmp r1
029D	00    	nop                 	
029E	00    	nop                 	
029F	00    	nop                 	
02A0	81fb00	push 00FB           	
02A3	30    	pop r1              	
				jmp r1
02A4	30    	pop r1              	
				jmp r1
02A5	00    	nop                 	
02A6	00    	nop                 	
02A7	00    	nop                 	
02A8	817405	push 0574           	
02AB	30    	pop r1              	
				jmp r1
02AC	30    	pop r1              	
				jmp r1
02AD	00    	nop                 	
02AE	00    	nop                 	
02AF	00    	nop                 	
02B0	81fb00	push 00FB           	
02B3	30    	pop r1              	
				jmp r1
02B4	81fb00	push 00FB           	
02B7	30    	pop r1              	
				jmp r1
02B8	30    	pop r1              	
				jmp r1
02B9	00    	nop                 	
02BA	00    	nop                 	
02BB	00    	nop                 	
02BC	30    	pop r1              	
				jmp r1
02BD	00    	nop                 	
02BE	00    	nop                 	
02BF	00    	nop                 	
02C0	81fb00	push 00FB           	
02C3	30    	pop r1              	
				jmp r1
02C4	30    	pop r1              	
				jmp r1
02C5	00    	nop                 	
02C6	00    	nop                 	
02C7	00    	nop                 	
02C8	81fb00	push 00FB           	
02CB	30    	pop r1              	
				jmp r1
02CC	817f05	push 057F           	
02CF	30    	pop r1              	
				jmp r1
02D0	30    	pop r1              	
				jmp r1
02D1	00    	nop                 	
02D2	00    	nop                 	
02D3	00    	nop                 	
02D4	30    	pop r1              	
				jmp r1
02D5	00    	nop                 	
02D6	00    	nop                 	
02D7	00    	nop                 	
02D8	81fb00	push 00FB           	
02DB	30    	pop r1              	
				jmp r1
02DC	30    	pop r1              	
				jmp r1
02DD	00    	nop                 	
02DE	00    	nop                 	
02DF	00    	nop                 	
02E0	81fb00	push 00FB           	
02E3	30    	pop r1              	
				jmp r1
02E4	30    	pop r1              	
				jmp r1
02E5	00    	nop                 	
02E6	00    	nop                 	
02E7	00    	nop                 	
02E8	81fb00	push 00FB           	
02EB	30    	pop r1              	
				jmp r1
02EC	30    	pop r1              	
				jmp r1
02ED	00    	nop                 	
02EE	00    	nop                 	
02EF	00    	nop                 	
02F0	81fb00	push 00FB           	
02F3	30    	pop r1              	
				jmp r1
02F4	81fb00	push 00FB           	
02F7	30    	pop r1              	
				jmp r1
02F8	30    	pop r1              	
				jmp r1
02F9	00    	nop                 	
02FA	00    	nop                 	
02FB	00    	nop                 	
02FC	81fb00	push 00FB           	
02FF	30    	pop r1              	
				jmp r1
0300	81fb00	push 00FB           	
0303	30    	pop r1              	
				jmp r1
0304	30    	pop r1              	
				jmp r1
0305	00    	nop                 	
0306	00    	nop                 	
0307	00    	nop                 	
0308	81fb00	push 00FB           	
030B	30    	pop r1              	
				jmp r1
030C	81fb00	push 00FB           	
030F	30    	pop r1              	
				jmp r1
0310	81fb00	push 00FB           	
0313	30    	pop r1              	
				jmp r1
0314	30    	pop r1              	
				jmp r1
0315	00    	nop                 	
0316	00    	nop                 	
0317	00    	nop                 	
0318	81fb00	push 00FB           	
031B	30    	pop r1              	
				jmp r1
031C	30    	pop r1              	
				jmp r1
031D	00    	nop                 	
031E	00    	nop                 	
031F	00    	nop                 	
0320	81fb00	push 00FB           	
0323	30    	pop r1              	
				jmp r1
0324	30    	pop r1              	
				jmp r1
0325	00    	nop                 	
0326	00    	nop                 	
0327	00    	nop                 	
0328	81fb00	push 00FB           	
032B	30    	pop r1              	
				jmp r1
032C	30    	pop r1              	
				jmp r1
032D	00    	nop                 	
032E	00    	nop                 	
032F	00    	nop                 	
0330	81fb00	push 00FB           	
0333	30    	pop r1              	
				jmp r1
0334	81fb00	push 00FB           	
0337	30    	pop r1              	
				jmp r1
0338	30    	pop r1              	
				jmp r1
0339	00    	nop                 	
033A	00    	nop                 	
033B	00    	nop                 	
033C	81fb00	push 00FB           	
033F	30    	pop r1              	
				jmp r1
0340	30    	pop r1              	
				jmp r1
0341	00    	nop                 	
0342	00    	nop                 	
0343	00    	nop                 	
0344	30    	pop r1              	
				jmp r1
0345	00    	nop                 	
0346	00    	nop                 	
0347	00    	nop                 	
0348	30    	pop r1              	
				jmp r1
0349	00    	nop                 	
034A	00    	nop                 	
034B	00    	nop                 	
034C	30    	pop r1              	
				jmp r1
034D	00    	nop                 	
034E	00    	nop                 	
034F	00    	nop                 	
0350	30    	pop r1              	
				jmp r1
0351	00    	nop                 	
0352	00    	nop                 	
0353	00    	nop                 	
0354	30    	pop r1              	
				jmp r1
0355	00    	nop                 	
0356	00    	nop                 	
0357	00    	nop                 	
0358	81fb00	push 00FB           	
035B	30    	pop r1              	
				jmp r1
035C	30    	pop r1              	
				jmp r1
035D	00    	nop                 	
035E	00    	nop                 	
035F	00    	nop                 	
0360	81fb00	push 00FB           	
0363	30    	pop r1              	
				jmp r1
0364	30    	pop r1              	
				jmp r1
0365	00    	nop                 	
0366	00    	nop                 	
0367	00    	nop                 	
0368	81fb00	push 00FB           	
036B	30    	pop r1              	
				jmp r1
036C	30    	pop r1              	
				jmp r1
036D	00    	nop                 	
036E	00    	nop                 	
036F	00    	nop                 	
0370	81fb00	push 00FB           	
0373	30    	pop r1              	
				jmp r1
0374	81fb00	push 00FB           	
0377	30    	pop r1              	
				jmp r1
0378	30    	pop r1              	
				jmp r1
0379	00    	nop                 	
037A	00    	nop                 	
037B	00    	nop                 	
037C	81fb00	push 00FB           	
037F	30    	pop r1              	
				jmp r1
0380	30    	pop r1              	
				jmp r1
0381	00    	nop                 	
0382	00    	nop                 	
0383	00    	nop                 	
0384	81fb00	push 00FB           	
0387	30    	pop r1              	
				jmp r1
0388	81fb00	push 00FB           	
038B	30    	pop r1              	
				jmp r1
038C	81fb00	push 00FB           	
038F	30    	pop r1              	
				jmp r1
0390	81fb00	push 00FB           	
0393	30    	pop r1              	
				jmp r1
0394	81fb00	push 00FB           	
0397	30    	pop r1              	
				jmp r1
0398	81fb00	push 00FB           	
039B	30    	pop r1              	
				jmp r1
039C	30    	pop r1              	
				jmp r1
039D	00    	nop                 	
039E	00    	nop                 	
039F	00    	nop                 	
03A0	81fb00	push 00FB           	
03A3	30    	pop r1              	
				jmp r1
03A4	30    	pop r1              	
				jmp r1
03A5	00    	nop                 	
03A6	00    	nop                 	
03A7	00    	nop                 	
03A8	81fb00	push 00FB           	
03AB	30    	pop r1              	
				jmp r1
03AC	30    	pop r1              	
				jmp r1
03AD	00    	nop                 	
03AE	00    	nop                 	
03AF	00    	nop                 	
03B0	81fb00	push 00FB           	
03B3	30    	pop r1              	
				jmp r1
03B4	81fb00	push 00FB           	
03B7	30    	pop r1              	
				jmp r1
03B8	30    	pop r1              	
				jmp r1
03B9	00    	nop                 	
03BA	00    	nop                 	
03BB	00    	nop                 	
03BC	81fb00	push 00FB           	
03BF	30    	pop r1              	
				jmp r1
03C0	30    	pop r1              	
				jmp r1
03C1	00    	nop                 	
03C2	00    	nop                 	
03C3	00    	nop                 	
03C4	30    	pop r1              	
				jmp r1
03C5	00    	nop                 	
03C6	00    	nop                 	
03C7	00    	nop                 	
03C8	30    	pop r1              	
				jmp r1
03C9	00    	nop                 	
03CA	00    	nop                 	
03CB	00    	nop                 	
03CC	30    	pop r1              	
				jmp r1
03CD	00    	nop                 	
03CE	00    	nop                 	
03CF	00    	nop                 	
03D0	30    	pop r1              	
				jmp r1
03D1	00    	nop                 	
03D2	00    	nop                 	
03D3	00    	nop                 	
03D4	30    	pop r1              	
				jmp r1
03D5	00    	nop                 	
03D6	00    	nop                 	
03D7	00    	nop                 	
03D8	30    	pop r1              	
				jmp r1
03D9	00    	nop                 	
03DA	00    	nop                 	
03DB	00    	nop                 	
03DC	30    	pop r1              	
				jmp r1
03DD	00    	nop                 	
03DE	00    	nop                 	
03DF	00    	nop                 	
03E0	81fb00	push 00FB           	
03E3	30    	pop r1              	
				jmp r1
03E4	30    	pop r1              	
				jmp r1
03E5	00    	nop                 	
03E6	00    	nop                 	
03E7	00    	nop                 	
03E8	81fb00	push 00FB           	
03EB	30    	pop r1              	
				jmp r1
03EC	30    	pop r1              	
				jmp r1
03ED	00    	nop                 	
03EE	00    	nop                 	
03EF	00    	nop                 	
03F0	81fb00	push 00FB           	
03F3	30    	pop r1              	
				jmp r1
03F4	81fb00	push 00FB           	
03F7	30    	pop r1              	
				jmp r1
03F8	30    	pop r1              	
				jmp r1
03F9	00    	nop                 	
03FA	00    	nop                 	
03FB	00    	nop                 	
03FC	81fb00	push 00FB           	
03FF	30    	pop r1              	
				jmp r1
0400	81fb00	push 00FB           	
0403	30    	pop r1              	
				jmp r1
0404	81fb00	push 00FB           	
0407	30    	pop r1              	
				jmp r1
0408	30    	pop r1              	
				jmp r1
0409	00    	nop                 	
040A	00    	nop                 	
040B	00    	nop                 	
040C	81fb00	push 00FB           	
040F	30    	pop r1              	
				jmp r1
0410	81fb00	push 00FB           	
0413	30    	pop r1              	
				jmp r1
0414	81fb00	push 00FB           	
0417	30    	pop r1              	
				jmp r1
0418	81fb00	push 00FB           	
041B	30    	pop r1              	
				jmp r1
041C	81fb00	push 00FB           	
041F	30    	pop r1              	
				jmp r1
0420	81fb00	push 00FB           	
0423	30    	pop r1              	
				jmp r1
0424	30    	pop r1              	
				jmp r1
0425	00    	nop                 	
0426	00    	nop                 	
0427	00    	nop                 	
0428	81fb00	push 00FB           	
042B	30    	pop r1              	
				jmp r1
042C	30    	pop r1              	
				jmp r1
042D	00    	nop                 	
042E	00    	nop                 	
042F	00    	nop                 	
0430	81fb00	push 00FB           	
0433	30    	pop r1              	
				jmp r1
0434	81fb00	push 00FB           	
0437	30    	pop r1              	
				jmp r1
0438	30    	pop r1              	
				jmp r1
0439	00    	nop                 	
043A	00    	nop                 	
043B	00    	nop                 	
043C	30    	pop r1              	
				jmp r1
043D	00    	nop                 	
043E	00    	nop                 	
043F	00    	nop                 	
0440	30    	pop r1              	
				jmp r1
0441	00    	nop                 	
0442	00    	nop                 	
0443	00    	nop                 	
0444	81fb00	push 00FB           	
0447	30    	pop r1              	
				jmp r1
0448	30    	pop r1              	
				jmp r1
0449	00    	nop                 	
044A	00    	nop                 	
044B	00    	nop                 	
044C	30    	pop r1              	
				jmp r1
044D	00    	nop                 	
044E	00    	nop                 	
044F	00    	nop                 	
0450	817405	push 0574           	
0453	30    	pop r1              	
				jmp r1
0454	30    	pop r1              	
				jmp r1
0455	00    	nop                 	
0456	00    	nop                 	
0457	00    	nop                 	
0458	30    	pop r1              	
				jmp r1
0459	00    	nop                 	
045A	00    	nop                 	
045B	00    	nop                 	
045C	81fb00	push 00FB           	
045F	30    	pop r1              	
				jmp r1
0460	30    	pop r1              	
				jmp r1
0461	00    	nop                 	
0462	00    	nop                 	
0463	00    	nop                 	
0464	30    	pop r1              	
				jmp r1
0465	00    	nop                 	
0466	00    	nop                 	
0467	00    	nop                 	
0468	81fb00	push 00FB           	
046B	30    	pop r1              	
				jmp r1
046C	30    	pop r1              	
				jmp r1
046D	00    	nop                 	
046E	00    	nop                 	
046F	00    	nop                 	
0470	81fb00	push 00FB           	
0473	30    	pop r1              	
				jmp r1
0474	81fb00	push 00FB           	
0477	30    	pop r1              	
				jmp r1
0478	30    	pop r1              	
				jmp r1
0479	00    	nop                 	
047A	00    	nop                 	
047B	00    	nop                 	
047C	81fb00	push 00FB           	
047F	30    	pop r1              	
				jmp r1
0480	81fb00	push 00FB           	
0483	30    	pop r1              	
				jmp r1
0484	81fb00	push 00FB           	
0487	30    	pop r1              	
				jmp r1
0488	30    	pop r1              	
				jmp r1
0489	00    	nop                 	
048A	00    	nop                 	
048B	00    	nop                 	
048C	30    	pop r1              	
				jmp r1
048D	00    	nop                 	
048E	00    	nop                 	
048F	00    	nop                 	
0490	81fb00	push 00FB           	
0493	30    	pop r1              	
				jmp r1
0494	30    	pop r1              	
				jmp r1
0495	00    	nop                 	
0496	00    	nop                 	
0497	00    	nop                 	
0498	30    	pop r1              	
				jmp r1
0499	00    	nop                 	
049A	00    	nop                 	
049B	00    	nop                 	
049C	81fb00	push 00FB           	
049F	30    	pop r1              	
				jmp r1
04A0	30    	pop r1              	
				jmp r1
04A1	00    	nop                 	
04A2	00    	nop                 	
04A3	00    	nop                 	
04A4	81fb00	push 00FB           	
04A7	30    	pop r1              	
				jmp r1
04A8	30    	pop r1              	
				jmp r1
04A9	00    	nop                 	
04AA	00    	nop                 	
04AB	00    	nop                 	
04AC	30    	pop r1              	
				jmp r1
04AD	00    	nop                 	
04AE	00    	nop                 	
04AF	00    	nop                 	
04B0	81fb00	push 00FB           	
04B3	30    	pop r1              	
				jmp r1
04B4	81fb00	push 00FB           	
04B7	30    	pop r1              	
				jmp r1
04B8	30    	pop r1              	
				jmp r1
04B9	00    	nop                 	
04BA	00    	nop                 	
04BB	00    	nop                 	
04BC	81fb00	push 00FB           	
04BF	30    	pop r1              	
				jmp r1
04C0	30    	pop r1              	
				jmp r1
04C1	00    	nop                 	
04C2	00    	nop                 	
04C3	00    	nop                 	
04C4	30    	pop r1              	
				jmp r1
04C5	00    	nop                 	
04C6	00    	nop                 	
04C7	00    	nop                 	
04C8	30    	pop r1              	
				jmp r1
04C9	00    	nop                 	
04CA	00    	nop                 	
04CB	00    	nop                 	
04CC	81fb00	push 00FB           	
04CF	30    	pop r1              	
				jmp r1
04D0	81fb00	push 00FB           	
04D3	30    	pop r1              	
				jmp r1
04D4	81fb00	push 00FB           	
04D7	30    	pop r1              	
				jmp r1
04D8	30    	pop r1              	
				jmp r1
04D9	00    	nop                 	
04DA	00    	nop                 	
04DB	00    	nop                 	
04DC	81fb00	push 00FB           	
04DF	30    	pop r1              	
				jmp r1
04E0	30    	pop r1              	
				jmp r1
04E1	00    	nop                 	
04E2	00    	nop                 	
04E3	00    	nop                 	
04E4	81fb00	push 00FB           	
04E7	30    	pop r1              	
				jmp r1
04E8	817405	push 0574           	
04EB	30    	pop r1              	
				jmp r1
04EC	81fb00	push 00FB           	
04EF	30    	pop r1              	
				jmp r1
04F0	81fb00	push 00FB           	
04F3	30    	pop r1              	
				jmp r1
04F4	81fb00	push 00FB           	
04F7	30    	pop r1              	
				jmp r1
04F8	30    	pop r1              	
				jmp r1
04F9	00    	nop                 	
04FA	00    	nop                 	
04FB	00    	nop                 	
04FC	81fb00	push 00FB           	
04FF	30    	pop r1              	
				jmp r1
0500	30    	pop r1              	
				jmp r1
0501	00    	nop                 	
0502	00    	nop                 	
0503	00    	nop                 	
0504	30    	pop r1              	
				jmp r1
0505	00    	nop                 	
0506	00    	nop                 	
0507	00    	nop                 	
0508	30    	pop r1              	
				jmp r1
0509	00    	nop                 	
050A	00    	nop                 	
050B	00    	nop                 	
050C	30    	pop r1              	
				jmp r1
050D	00    	nop                 	
050E	00    	nop                 	
050F	00    	nop                 	
0510	81fb00	push 00FB           	
0513	30    	pop r1              	
				jmp r1
0514	30    	pop r1              	
				jmp r1
0515	00    	nop                 	
0516	00    	nop                 	
0517	00    	nop                 	
0518	30    	pop r1              	
				jmp r1
0519	00    	nop                 	
051A	00    	nop                 	
051B	00    	nop                 	
051C	817405	push 0574           	
051F	30    	pop r1              	
				jmp r1
0520	30    	pop r1              	
				jmp r1
0521	00    	nop                 	
0522	00    	nop                 	
0523	00    	nop                 	
0524	81fb00	push 00FB           	
0527	30    	pop r1              	
				jmp r1
0528	30    	pop r1              	
				jmp r1
0529	00    	nop                 	
052A	00    	nop                 	
052B	00    	nop                 	
052C	30    	pop r1              	
				jmp r1
052D	00    	nop                 	
052E	00    	nop                 	
052F	00    	nop                 	
0530	81fb00	push 00FB           	
0533	30    	pop r1              	
				jmp r1
0534	81fb00	push 00FB           	
0537	30    	pop r1              	
				jmp r1
0538	81fb00	push 00FB           	
053B	30    	pop r1              	
				jmp r1
053C	81fb00	push 00FB           	
053F	30    	pop r1              	
				jmp r1
0540	81fb00	push 00FB           	
0543	30    	pop r1              	
				jmp r1
0544	81fb00	push 00FB           	
0547	30    	pop r1              	
				jmp r1
0548	81fb00	push 00FB           	
054B	30    	pop r1              	
				jmp r1
054C	81fb00	push 00FB           	
054F	30    	pop r1              	
				jmp r1
0550	81fb00	push 00FB           	
0553	30    	pop r1              	
				jmp r1
0554	81fb00	push 00FB           	
0557	30    	pop r1              	
				jmp r1
0558	81fb00	push 00FB           	
055B	30    	pop r1              	
				jmp r1
055C	81fb00	push 00FB           	
055F	30    	pop r1              	
				jmp r1
0560	81fb00	push 00FB           	
0563	30    	pop r1              	
				jmp r1
0564	81fb00	push 00FB           	
0567	30    	pop r1              	
				jmp r1
0568	81fb00	push 00FB           	
056B	30    	pop r1              	
				jmp r1
056C	818505	push 0585           	
056F	30    	pop r1              	
				jmp r1
0570	81fb00	push 00FB           	
0573	30    	pop r1              	
				jmp r1
0574	20    	pop r1              	
				push_e r1
0575	10    	push [sp-2]         	
0576	81fb00	push 00FB           	
0579	31    	pop r1              	
				pop r2
				test r2, r2
				jnz 057A
				jmp r1
057A	8001  	push 0001           	
057C	13    	pop r1              	
				sub [sp-2], r1
057D	21    	pop_e r1            	
				push r1
057E	30    	pop r1              	
				jmp r1
057F	20    	pop r1              	
				push_e r1
0580	8001  	push 0001           	
0582	12    	pop r1              	
				add [sp-2], r1
0583	21    	pop_e r1            	
				push r1
0584	30    	pop r1              	
				jmp r1
0585	11    	pop r1              	
0586	11    	pop r1              	
0587	11    	pop r1              	
0588	11    	pop r1              	
0589	81ce05	push 05CE           	
058C	8000  	push 0000           	
058E	800a  	push 000A           	
0590	8021  	push 0021           	
0592	8074  	push 0074           	
0594	8069  	push 0069           	
0596	8020  	push 0020           	
0598	8065  	push 0065           	
059A	8064  	push 0064           	
059C	8061  	push 0061           	
059E	806d  	push 006D           	
05A0	8020  	push 0020           	
05A2	8075  	push 0075           	
05A4	806f  	push 006F           	
05A6	8079  	push 0079           	
05A8	8020  	push 0020           	
05AA	802c  	push 002C           	
05AC	8073  	push 0073           	
05AE	806e  	push 006E           	
05B0	806f  	push 006F           	
05B2	8069  	push 0069           	
05B4	8074  	push 0074           	
05B6	8061  	push 0061           	
05B8	806c  	push 006C           	
05BA	8075  	push 0075           	
05BC	8074  	push 0074           	
05BE	8061  	push 0061           	
05C0	8072  	push 0072           	
05C2	8067  	push 0067           	
05C4	806e  	push 006E           	
05C6	806f  	push 006F           	
05C8	8043  	push 0043           	
05CA	813b01	push 013B           	
05CD	30    	pop r1              	
				jmp r1
05CE	81f800	push 00F8           	
