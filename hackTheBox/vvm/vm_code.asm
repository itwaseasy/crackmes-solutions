; Calculates each character from the string `What is the password: `
; and pushes them onto the stack.

19 00 00 00 ae 00 00 00
                                                  push 0xae
19 00 00 00 02 00 00 00                           
                                                  push 0x02
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
19 00 00 00 34 00 00 00                           
                                                  push 0x34
19 00 00 00 02 00 00 00                           
                                                  push 0x02
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
17 00 00 00                                       
                                                  push [sp-4]
19 00 00 00 07 00 00 00                           
                                                  push 0x07
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 04 00 00 00                           
                                                  push 0x04
19 00 00 00 0e 00 00 00                           
                                                  push 0x0e
19 00 00 00 08 00 00 00                           
                                                  push 0x08
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 04 00 00 00                           
                                                  push 0x04
19 00 00 00 10 00 00 00                           
                                                  push 0x10
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 02 00 00 00                           
                                                  push 0x02
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
19 00 00 00 03 00 00 00                           
                                                  push 0x03
19 00 00 00 25 00 00 00                           
                                                  push 0x25
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 06 00 00 00                           
                                                  push 0x06
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 01 00 00 00                           
                                                  push 0x01
19 00 00 00 15 00 00 00                           
                                                  push 0x15
0c 00 00 00                                       
                                                  pop r1
                                                  mul r1, 3
                                                  sub r1, 6
                                                  add r1, r1
                                                  push r1
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 40 00 00 00                           
                                                  push 0x40
19 00 00 00 02 00 00 00                           
                                                  push 0x02
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
19 00 00 00 04 00 00 00                           
                                                  push 0x04
19 00 00 00 0b 00 00 00                           
                                                  push 0x0b
15 00 00 00                                       
                                                  pop r1
                                                  mul r1, 8
                                                  add r1, 24
                                                  push r1
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
17 00 00 00                                       
                                                  push [sp-4]
19 00 00 00 0c 00 00 00                           
                                                  push 0x0c
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 01 00 00 00                           
                                                  push 0x01
19 00 00 00 06 00 00 00                           
                                                  push 0x06
09 00 00 00                                       
                                                  pop r1
                                                  add r1, 17
                                                  mod r1, 3
                                                  push r1
19 00 00 00 32 00 00 00                           
                                                  push 0x32
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 03 00 00 00                           
                                                  push 0x03
19 00 00 00 0a 00 00 00                           
                                                  push 0x0a
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 02 00 00 00                           
                                                  push 0x02
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
17 00 00 00                                       
                                                  push [sp-4]
0c 00 00 00                                       
                                                  pop r1
                                                  mul r1, 3
                                                  sub r1, 6
                                                  add r1, r1
                                                  push r1
19 00 00 00 44 00 00 00                           
                                                  push 0x44
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 01 00 00 00                           
                                                  push 0x01
19 00 00 00 09 00 00 00                           
                                                  push 0x09
15 00 00 00                                       
                                                  pop r1
                                                  mul r1, 8
                                                  add r1, 24
                                                  push r1
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 23 00 00 00                           
                                                  push 0x23
19 00 00 00 03 00 00 00                           
                                                  push 0x03
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 19 00 00 00                           
                                                  push 0x19
19 00 00 00 0f 00 00 00                           
                                                  push 0x0f
02 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mod r1, r2
                                                  push r1
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
17 00 00 00                                       
                                                  push [sp-4]
19 00 00 00 02 00 00 00                           
                                                  push 0x02
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 02 00 00 00                           
                                                  push 0x02
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
19 00 00 00 be 00 00 00                           
                                                  push 0xbe
19 00 00 00 02 00 00 00                           
                                                  push 0x02
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
; just in case you try to debug it
07 00 00 00
                                                  ptrace_traceme_check()
19 00 00 00 03 00 00 00                           
                                                  push 0x03
09 00 00 00                                       
                                                  pop r1
                                                  add r1, 17
                                                  mod r1, 3
                                                  push r1
19 00 00 00 0c 00 00 00                           
                                                  push 0x0c
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 36 00 00 00                           
                                                  push 0x36
19 00 00 00 02 00 00 00                           
                                                  push 0x02
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 03 00 00 00                           
                                                  push 0x03
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
17 00 00 00                                       
                                                  push [sp-4]
19 00 00 00 03 00 00 00                           
                                                  push 0x03
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 1b 00 00 00                           
                                                  push 0x1b
0c 00 00 00                                       
                                                  pop r1
                                                  mul r1, 3
                                                  sub r1, 6
                                                  add r1, r1
                                                  push r1
19 00 00 00 30 00 00 00                           
                                                  push 0x30
19 00 00 00 02 00 00 00                           
                                                  push 0x02
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 ae 00 00 00                           
                                                  push 0xae
19 00 00 00 03 00 00 00                           
                                                  push 0x03
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
19 00 00 00 01 00 00 00                           
                                                  push 0x01
15 00 00 00                                       
                                                  pop r1
                                                  mul r1, 8
                                                  add r1, 24
                                                  push r1

; prints the resulting `What is the password: ` string
0f 00 00 00 16 00 00 00                           
                                                  mov r2, 0x16
                                                  r1 = malloc(r2)
                                                  memcpy(r1, [sp-4-r2])
                                                  add sp, r2
                                                  push r1
0a 00 00 00                                       
                                                  pop r1
                                                  print(r1)
                                                  free(r1)

; reads the input and removes the '\n' character(s)
03 00 00 00 20 00 00 00                           
                                                  mov r2, 0x20
                                                  r1 = malloc(r2)
                                                  getline(r1, r2, stdin)
                                                  push r1
0d 00 00 00                                       
                                                  remove_linefeed_from_buffer()
17 00 00 00                                       
                                                  push [sp-4]
00 00 00 00                                       
                                                  pop r1
                                                  r1 = strlen(r1)
                                                  push r1

; computes a value that is the correct length of the flag
0c 00 00 00                                       
                                                  pop r1
                                                  mul r1, 3
                                                  sub r1, 6
                                                  add r1, r1
                                                  push r1
19 00 00 00 04 00 00 00                           
                                                  push 0x04
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 02 00 00 00                           
                                                  push 0x02
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
15 00 00 00                                       
                                                  pop r1
                                                  mul r1, 8
                                                  add r1, 24
                                                  push r1
19 00 00 00 05 00 00 00                           
                                                  push 0x05
19 00 00 00 02 00 00 00                           
                                                  push 0x02
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
19 00 00 00 16 00 00 00                           
                                                  push 0x16
19 00 00 00 07 00 00 00                           
                                                  push 0x07
19 00 00 00 04 00 00 00                           
                                                  push 0x04
02 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mod r1, r2
                                                  push r1
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 04 00 00 00                           
                                                  push 0x04
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1

; compares the size of the input string and the calculated value
13 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  cmp r1, r2
                                                  setz r1
                                                  push r1
16 00 00 00 61 00 00 00                           
                                                  pop r1
                                                  cmp r1, 0
                                                  jz [0x61*4]       ; check flag

; calculates each character of the "incorrect" string, pushes them onto the
; stack and prints them

19 00 00 00 54 00 00 00                           
                                                  push 0x54
19 00 00 00 0b 00 00 00                           
                                                  push 0x0b
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 02 00 00 00                           
                                                  push 0x02
19 00 00 00 37 00 00 00                           
                                                  push 0x37
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 09 00 00 00                           
                                                  push 0x09
15 00 00 00                                       
                                                  pop r1
                                                  mul r1, 8
                                                  add r1, 24
                                                  push r1
19 00 00 00 03 00 00 00                           
                                                  push 0x03
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 38 00 00 00                           
                                                  push 0x38
09 00 00 00                                       
                                                  pop r1
                                                  add r1, 17
                                                  mod r1, 3
                                                  push r1
19 00 00 00 37 00 00 00                           
                                                  push 0x37
19 00 00 00 02 00 00 00                           
                                                  push 0x02
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
17 00 00 00                                       
                                                  push [sp-4]
19 00 00 00 03 00 00 00                           
                                                  push 0x03
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 03 00 00 00                           
                                                  push 0x03
19 00 00 00 15 00 00 00                           
                                                  push 0x15
19 00 00 00 02 00 00 00                           
                                                  push 0x02
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 0c 00 00 00                           
                                                  push 0x0c
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 cc 00 00 00                           
                                                  push 0xcc
19 00 00 00 02 00 00 00                           
                                                  push 0x02
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
19 00 00 00 01 00 00 00                           
                                                  push 0x01
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 1f 00 00 00                           
                                                  push 0x1f
19 00 00 00 02 00 00 00                           
                                                  push 0x02
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 03 00 00 00                           
                                                  push 0x03
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 50 00 00 00                           
                                                  push 0x50
19 00 00 00 2d 00 00 00                           
                                                  push 0x2d
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 09 00 00 00                           
                                                  push 0x09
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 04 00 00 00                           
                                                  push 0x04
19 00 00 00 08 00 00 00                           
                                                  push 0x08
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 1d 00 00 00                           
                                                  push 0x1d
19 00 00 00 02 00 00 00                           
                                                  push 0x02
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 5a 00 00 00                           
                                                  push 0x5a
19 00 00 00 03 00 00 00                           
                                                  push 0x03
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
19 00 00 00 05 00 00 00                           
                                                  push 0x05
19 00 00 00 02 00 00 00                           
                                                  push 0x02
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 1f 00 00 00                           
                                                  push 0x1f
19 00 00 00 0b 00 00 00                           
                                                  push 0x0b
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 02 00 00 00                           
                                                  push 0x02
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
0f 00 00 00 0d 00 00 00                           
                                                  mov r2, 0x0d
                                                  r1 = malloc(r2)
                                                  memcpy(r1, [sp-4-r2])
                                                  add sp, r2
                                                  push r1
0a 00 00 00                                       
                                                  pop r1
                                                  print(r1)
                                                  free(r1)
1c 00 00 00                                       
                                                  ret

check_flag:

0b 00 00 00 16 00 00 00                           
                                                  jmp [0x16*4]      ; calculate_round1


calculate_round1_value:

10 00 00 00 03 00 00 00                           
                                                  mov r1, [sp-4-0x03*4]
                                                  push r1
10 00 00 00 03 00 00 00                           
                                                  mov r1, [sp-4-0x03*4]
                                                  push r1
19 00 00 00 08 00 00 00                           
                                                  push 0x08
01 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  shl r1, r2
                                                  push r1
08 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  or r1, r2
                                                  push r1
10 00 00 00 02 00 00 00                           
                                                  mov r1, [sp-4-0x02*4]
                                                  push r1
19 00 00 00 10 00 00 00                           
                                                  push 0x10
01 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  shl r1, r2
                                                  push r1
08 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  or r1, r2
                                                  push r1
10 00 00 00 01 00 00 00                           
                                                  mov r1, [sp-4-0x01*4]
                                                  push r1
19 00 00 00 18 00 00 00                           
                                                  push 0x18
01 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  shl r1, r2
                                                  push r1
08 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  or r1, r2
                                                  push r1
1c 00 00 00                                       
                                                  ret
17 00 00 00



calculate_round1:
                                                  push [sp-4]
12 00 00 00 18 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x18]
                                                  push r1
10 00 00 00 01 00 00 00                           
                                                  mov r1, [sp-4-0x01*4]
                                                  push r1
12 00 00 00 0e 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x0e]
                                                  push r1
10 00 00 00 02 00 00 00                           
                                                  mov r1, [sp-4-0x02*4]
                                                  push r1
12 00 00 00 1b 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x1b]
                                                  push r1
10 00 00 00 03 00 00 00                           
                                                  mov r1, [sp-4-0x03*4]
                                                  push r1
12 00 00 00 0f 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x0f]
                                                  push r1
11 00 00 00 1a 01 00 00 04 00 00 00               
                                                  call [0x11a*4]        ; calculate_round1_value
                                                  pop r1
                                                  sub sp, 0x04*4
                                                  push r1
10 00 00 00 01 00 00 00                           
                                                  mov r1, [sp-4-0x01*4]
                                                  push r1
12 00 00 00 0b 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x0b]
                                                  push r1
10 00 00 00 02 00 00 00                           
                                                  mov r1, [sp-4-0x02*4]
                                                  push r1
12 00 00 00 07 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x07]
                                                  push r1
10 00 00 00 03 00 00 00                           
                                                  mov r1, [sp-4-0x03*4]
                                                  push r1
12 00 00 00 0c 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x0c]
                                                  push r1
10 00 00 00 04 00 00 00                           
                                                  mov r1, [sp-4-0x04*4]
                                                  push r1
12 00 00 00 04 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x04]
                                                  push r1
11 00 00 00 1a 01 00 00 04 00 00 00               
                                                  call [0x11a*4]        ; calculate_round1_value
                                                  pop r1
                                                  sub sp, 0x04*4
                                                  push r1
10 00 00 00 02 00 00 00                           
                                                  mov r1, [sp-4-0x02*4]
                                                  push r1
12 00 00 00 06 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x06]
                                                  push r1
10 00 00 00 03 00 00 00                           
                                                  mov r1, [sp-4-0x03*4]
                                                  push r1
12 00 00 00 09 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x09]
                                                  push r1
10 00 00 00 04 00 00 00                           
                                                  mov r1, [sp-4-0x04*4]
                                                  push r1
12 00 00 00 02 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x02]
                                                  push r1
10 00 00 00 05 00 00 00                           
                                                  mov r1, [sp-4-0x05*4]
                                                  push r1
12 00 00 00 12 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x12]
                                                  push r1
11 00 00 00 1a 01 00 00 04 00 00 00               
                                                  call [0x11a*4]        ; calculate_round1_value
                                                  pop r1
                                                  sub sp, 0x04*4
                                                  push r1
10 00 00 00 03 00 00 00                           
                                                  mov r1, [sp-4-0x03*4]
                                                  push r1
12 00 00 00 13 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x13]
                                                  push r1
10 00 00 00 04 00 00 00                           
                                                  mov r1, [sp-4-0x04*4]
                                                  push r1
12 00 00 00 0d 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x0d]
                                                  push r1
10 00 00 00 05 00 00 00                           
                                                  mov r1, [sp-4-0x05*4]
                                                  push r1
12 00 00 00 14 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x14]
                                                  push r1
10 00 00 00 06 00 00 00                           
                                                  mov r1, [sp-4-0x06*4]
                                                  push r1
12 00 00 00 1a 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x1a]
                                                  push r1
11 00 00 00 1a 01 00 00 04 00 00 00               
                                                  call [0x11a*4]        ; calculate_round1_value
                                                  pop r1
                                                  sub sp, 0x04*4
                                                  push r1
10 00 00 00 04 00 00 00                           
                                                  mov r1, [sp-4-0x04*4]
                                                  push r1
12 00 00 00 1c 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x1c]
                                                  push r1
10 00 00 00 05 00 00 00                           
                                                  mov r1, [sp-4-0x05*4]
                                                  push r1
12 00 00 00 10 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x10]
                                                  push r1
10 00 00 00 06 00 00 00                           
                                                  mov r1, [sp-4-0x06*4]
                                                  push r1
12 00 00 00 17 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x17]
                                                  push r1
10 00 00 00 07 00 00 00                           
                                                  mov r1, [sp-4-0x07*4]
                                                  push r1
12 00 00 00 08 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x08]
                                                  push r1
11 00 00 00 1a 01 00 00 04 00 00 00               
                                                  call [0x11a*4]        ; calculate_round1_value
                                                  pop r1
                                                  sub sp, 0x04*4
                                                  push r1
10 00 00 00 05 00 00 00                           
                                                  mov r1, [sp-4-0x05*4]
                                                  push r1
12 00 00 00 03 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x03]
                                                  push r1
10 00 00 00 06 00 00 00                           
                                                  mov r1, [sp-4-0x06*4]
                                                  push r1
12 00 00 00 1e 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x1e]
                                                  push r1
10 00 00 00 07 00 00 00                           
                                                  mov r1, [sp-4-0x07*4]
                                                  push r1
12 00 00 00 15 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x15]
                                                  push r1
10 00 00 00 08 00 00 00                           
                                                  mov r1, [sp-4-0x08*4]
                                                  push r1
12 00 00 00 16 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x16]
                                                  push r1
11 00 00 00 1a 01 00 00 04 00 00 00               
                                                  call [0x11a*4]        ; calculate_round1_value
                                                  pop r1
                                                  sub sp, 0x04*4
                                                  push r1
10 00 00 00 06 00 00 00                           
                                                  mov r1, [sp-4-0x06*4]
                                                  push r1
12 00 00 00 19 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x19]
                                                  push r1
10 00 00 00 07 00 00 00                           
                                                  mov r1, [sp-4-0x07*4]
                                                  push r1
12 00 00 00 05 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x05]
                                                  push r1
10 00 00 00 08 00 00 00                           
                                                  mov r1, [sp-4-0x08*4]
                                                  push r1
12 00 00 00 0a 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x0a]
                                                  push r1
10 00 00 00 09 00 00 00                           
                                                  mov r1, [sp-4-0x09*4]
                                                  push r1
12 00 00 00 1f 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x1f]
                                                  push r1
11 00 00 00 1a 01 00 00 04 00 00 00               
                                                  call [0x11a*4]        ; calculate_round1_value
                                                  pop r1
                                                  sub sp, 0x04*4
                                                  push r1
10 00 00 00 07 00 00 00                           
                                                  mov r1, [sp-4-0x07*4]
                                                  push r1
12 00 00 00 1d 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x1d]
                                                  push r1
10 00 00 00 08 00 00 00                           
                                                  mov r1, [sp-4-0x08*4]
                                                  push r1
12 00 00 00 01 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x01]
                                                  push r1
10 00 00 00 09 00 00 00                           
                                                  mov r1, [sp-4-0x09*4]
                                                  push r1
12 00 00 00 00 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x00]
                                                  push r1
10 00 00 00 0a 00 00 00                           
                                                  mov r1, [sp-4-0x0a*4]
                                                  push r1
12 00 00 00 11 00 00 00                           
                                                  pop r1
                                                  mov r1, [r1+0x11]
                                                  push r1
11 00 00 00 1a 01 00 00 04 00 00 00               
                                                  call [0x11a*4]        ; calculate_round1_value
                                                  pop r1
                                                  sub sp, 0x04*4
                                                  push r1
0b 00 00 00 10 00 00 00                           
                                                  jmp [0x10*4]          ; calculate_round2


calculate_round2_value:

10 00 00 00 01 00 00 00                           
                                                  mov r1, [sp-4-0x01*4]
                                                  push r1
10 00 00 00 01 00 00 00                           
                                                  mov r1, [sp-4-0x01*4]
                                                  push r1
01 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  shl r1, r2
                                                  push r1
10 00 00 00 02 00 00 00                           
                                                  mov r1, [sp-4-0x02*4]
                                                  push r1
19 00 00 00 20 00 00 00                           
                                                  push 0x20
10 00 00 00 03 00 00 00                           
                                                  mov r1, [sp-4-0x03*4]
                                                  push r1
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
1a 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  shr r1, r2
                                                  push r1
08 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  or r1, r2
                                                  push r1
1c 00 00 00                                       
                                                  ret
17 00 00 00


calculate_round2:
                                                  push [sp-4]
19 00 00 00 08 00 00 00                           
                                                  push 0x08
19 00 00 00 07 00 00 00                           
                                                  push 0x07
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
11 00 00 00 c8 01 00 00 02 00 00 00               
                                                  call [0x1c8*4]        ; calculate_round2_value
                                                  pop r1
                                                  sub sp, 0x02*4
                                                  push r1
10 00 00 00 02 00 00 00                           
                                                  mov r1, [sp-4-0x02*4]
                                                  push r1
19 00 00 00 18 00 00 00                           
                                                  push 0x18
19 00 00 00 05 00 00 00                           
                                                  push 0x05
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
11 00 00 00 c8 01 00 00 02 00 00 00               
                                                  call [0x1c8*4]        ; calculate_round2_value
                                                  pop r1
                                                  sub sp, 0x02*4
                                                  push r1
10 00 00 00 04 00 00 00                           
                                                  mov r1, [sp-4-0x04*4]
                                                  push r1
19 00 00 00 04 00 00 00                           
                                                  push 0x04
19 00 00 00 03 00 00 00                           
                                                  push 0x03
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
11 00 00 00 c8 01 00 00 02 00 00 00               
                                                  call [0x1c8*4]        ; calculate_round2_value
                                                  pop r1
                                                  sub sp, 0x02*4
                                                  push r1
10 00 00 00 06 00 00 00                           
                                                  mov r1, [sp-4-0x06*4]
                                                  push r1
19 00 00 00 0b 00 00 00                           
                                                  push 0x0b
19 00 00 00 07 00 00 00                           
                                                  push 0x07
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
11 00 00 00 c8 01 00 00 02 00 00 00               
                                                  call [0x1c8*4]        ; calculate_round2_value
                                                  pop r1
                                                  sub sp, 0x02*4
                                                  push r1
10 00 00 00 08 00 00 00                           
                                                  mov r1, [sp-4-0x08*4]
                                                  push r1
19 00 00 00 18 00 00 00                           
                                                  push 0x18
19 00 00 00 02 00 00 00                           
                                                  push 0x02
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
11 00 00 00 c8 01 00 00 02 00 00 00               
                                                  call [0x1c8*4]        ; calculate_round2_value
                                                  pop r1
                                                  sub sp, 0x02*4
                                                  push r1
10 00 00 00 0a 00 00 00                           
                                                  mov r1, [sp-4-0x0a*4]
                                                  push r1
19 00 00 00 05 00 00 00                           
                                                  push 0x05
19 00 00 00 04 00 00 00                           
                                                  push 0x04
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
11 00 00 00 c8 01 00 00 02 00 00 00               
                                                  call [0x1c8*4]        ; calculate_round2_value
                                                  pop r1
                                                  sub sp, 0x02*4
                                                  push r1
10 00 00 00 0c 00 00 00                           
                                                  mov r1, [sp-4-0x0c*4]
                                                  push r1
19 00 00 00 11 00 00 00                           
                                                  push 0x11
19 00 00 00 03 00 00 00                           
                                                  push 0x03
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
11 00 00 00 c8 01 00 00 02 00 00 00               
                                                  call [0x1c8*4]        ; calculate_round2_value
                                                  pop r1
                                                  sub sp, 0x02*4
                                                  push r1
10 00 00 00 0e 00 00 00                           
                                                  mov r1, [sp-4-0x0e*4]
                                                  push r1
19 00 00 00 33 00 00 00                           
                                                  push 0x33
19 00 00 00 03 00 00 00                           
                                                  push 0x03
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
19 00 00 00 0a 00 00 00                           
                                                  push 0x0a
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
11 00 00 00 c8 01 00 00 02 00 00 00               
                                                  call [0x1c8*4]        ; calculate_round2_value
                                                  pop r1
                                                  sub sp, 0x02*4
                                                  push r1

; check round2 values with hard-coded integers

10 00 00 00 07 00 00 00                           
                                                  mov r1, [sp-4-0x07*4]
                                                  push r1
19 00 00 00 24 98 23 2a                           
                                                  push 0x2a239824
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
10 00 00 00 07 00 00 00                           
                                                  mov r1, [sp-4-0x07*4]
                                                  push r1
19 00 00 00 61 ea 73 8a                           
                                                  push 0x8a73ea61
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
10 00 00 00 07 00 00 00                           
                                                  mov r1, [sp-4-0x07*4]
                                                  push r1
19 00 00 00 99 bd 3c ba                           
                                                  push 0xba3cbd99
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
10 00 00 00 07 00 00 00                           
                                                  mov r1, [sp-4-0x07*4]
                                                  push r1
19 00 00 00 0d d5 bd dd                           
                                                  push 0xddbdd50d
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
10 00 00 00 07 00 00 00                           
                                                  mov r1, [sp-4-0x07*4]
                                                  push r1
19 00 00 00 05 43 44 f3                           
                                                  push 0xf3444305
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
10 00 00 00 07 00 00 00                           
                                                  mov r1, [sp-4-0x07*4]
                                                  push r1
19 00 00 00 23 24 27 47                           
                                                  push 0x47272423
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
10 00 00 00 07 00 00 00                           
                                                  mov r1, [sp-4-0x07*4]
                                                  push r1
19 00 00 00 9c dd 17 15                           
                                                  push 0x1517dd9c
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
10 00 00 00 07 00 00 00                           
                                                  mov r1, [sp-4-0x07*4]
                                                  push r1
19 00 00 00 29 b4 39 b6                           
                                                  push 0xb639b429
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
16 00 00 00 5c 00 00 00                           
                                                  pop r1
                                                  cmp r1, 0
                                                  jz [0x5c*4]
16 00 00 00 5b 00 00 00                           
                                                  pop r1
                                                  cmp r1, 0
                                                  jz [0x5b*4]
16 00 00 00 5a 00 00 00                           
                                                  pop r1
                                                  cmp r1, 0
                                                  jz [0x5a*4]
16 00 00 00 59 00 00 00                           
                                                  pop r1
                                                  cmp r1, 0
                                                  jz [0x59*4]
16 00 00 00 58 00 00 00                           
                                                  pop r1
                                                  cmp r1, 0
                                                  jz [0x58*4]
16 00 00 00 57 00 00 00                           
                                                  pop r1
                                                  cmp r1, 0
                                                  jz [0x57*4]
16 00 00 00 56 00 00 00                           
                                                  pop r1
                                                  cmp r1, 0
                                                  jz [0x56*4]
16 00 00 00 55 00 00 00                           
                                                  pop r1
                                                  cmp r1, 0
                                                  jz [0x55*4]
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4

; calculate each character of the "correct" string, push them onto
; the stack, and print the resulting string

19 00 00 00 20 00 00 00                           
                                                  push 0x20
19 00 00 00 02 00 00 00                           
                                                  push 0x02
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 03 00 00 00                           
                                                  push 0x03
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 8c 00 00 00                           
                                                  push 0x8c
19 00 00 00 02 00 00 00                           
                                                  push 0x02
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
19 00 00 00 29 00 00 00                           
                                                  push 0x29
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
17 00 00 00                                       
                                                  push [sp-4]
19 00 00 00 03 00 00 00                           
                                                  push 0x03
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
17 00 00 00                                       
                                                  push [sp-4]
19 00 00 00 02 00 00 00                           
                                                  push 0x02
19 00 00 00 21 00 00 00                           
                                                  push 0x21
19 00 00 00 03 00 00 00                           
                                                  push 0x03
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 12 00 00 00                           
                                                  push 0x12
0c 00 00 00                                       
                                                  pop r1
                                                  mul r1, 3
                                                  sub r1, 6
                                                  add r1, r1
                                                  push r1
19 00 00 00 03 00 00 00                           
                                                  push 0x03
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 0c 00 00 00                           
                                                  push 0x0c
15 00 00 00                                       
                                                  pop r1
                                                  mul r1, 8
                                                  add r1, 24
                                                  push r1
19 00 00 00 04 00 00 00                           
                                                  push 0x04
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 03 00 00 00                           
                                                  push 0x03
19 00 00 00 0f 00 00 00                           
                                                  push 0x0f
19 00 00 00 02 00 00 00                           
                                                  push 0x02
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 15 00 00 00                           
                                                  push 0x15
19 00 00 00 01 00 00 00                           
                                                  push 0x01
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 02 00 00 00                           
                                                  push 0x02
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
0f 00 00 00 09 00 00 00                           
                                                  mov r2, 0x09
                                                  r1 = malloc(r2)
                                                  memcpy(r1, [sp-4-r2])
                                                  add sp, r2
                                                  push r1
0a 00 00 00                                       
                                                  pop r1
                                                  print(r1)
                                                  free(r1)
1c 00 00 00                                       
                                                  ret
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4
0e 00 00 00                                       
                                                  add sp, 4


; calculate each character of the "incorrect" string, push them onto
; the stack, and print the resulting string

19 00 00 00 54 00 00 00                           
                                                  push 0x54
19 00 00 00 0b 00 00 00                           
                                                  push 0x0b
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 02 00 00 00                           
                                                  push 0x02
19 00 00 00 37 00 00 00                           
                                                  push 0x37
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 09 00 00 00                           
                                                  push 0x09
15 00 00 00                                       
                                                  pop r1
                                                  mul r1, 8
                                                  add r1, 24
                                                  push r1
19 00 00 00 03 00 00 00                           
                                                  push 0x03
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 38 00 00 00                           
                                                  push 0x38
09 00 00 00                                       
                                                  pop r1
                                                  add r1, 17
                                                  mod r1, 3
                                                  push r1
19 00 00 00 37 00 00 00                           
                                                  push 0x37
19 00 00 00 02 00 00 00                           
                                                  push 0x02
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
17 00 00 00                                       
                                                  push [sp-4]
19 00 00 00 03 00 00 00                           
                                                  push 0x03
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 03 00 00 00                           
                                                  push 0x03
19 00 00 00 15 00 00 00                           
                                                  push 0x15
19 00 00 00 02 00 00 00                           
                                                  push 0x02
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 0c 00 00 00                           
                                                  push 0x0c
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 cc 00 00 00                           
                                                  push 0xcc
19 00 00 00 02 00 00 00                           
                                                  push 0x02
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
19 00 00 00 01 00 00 00                           
                                                  push 0x01
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 1f 00 00 00                           
                                                  push 0x1f
19 00 00 00 02 00 00 00                           
                                                  push 0x02
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 03 00 00 00                           
                                                  push 0x03
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 50 00 00 00                           
                                                  push 0x50
19 00 00 00 2d 00 00 00                           
                                                  push 0x2d
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 09 00 00 00                           
                                                  push 0x09
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 04 00 00 00                           
                                                  push 0x04
19 00 00 00 08 00 00 00                           
                                                  push 0x08
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 1d 00 00 00                           
                                                  push 0x1d
19 00 00 00 02 00 00 00                           
                                                  push 0x02
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
19 00 00 00 5a 00 00 00                           
                                                  push 0x5a
19 00 00 00 03 00 00 00                           
                                                  push 0x03
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
19 00 00 00 05 00 00 00                           
                                                  push 0x05
19 00 00 00 02 00 00 00                           
                                                  push 0x02
06 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  mul r1, r2
                                                  push r1
05 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  add r1, r2
                                                  push r1
19 00 00 00 1f 00 00 00                           
                                                  push 0x1f
19 00 00 00 0b 00 00 00                           
                                                  push 0x0b
18 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  sub r1, r2
                                                  push r1
19 00 00 00 02 00 00 00                           
                                                  push 0x02
04 00 00 00                                       
                                                  pop r2
                                                  pop r1
                                                  div r1, r2
                                                  push r1
0f 00 00 00 0d 00 00 00                           
                                                  mov r2, 0x0d
                                                  r1 = malloc(r2)
                                                  memcpy(r1, [sp-4-r2])
                                                  add sp, r2
                                                  push r1
0a 00 00 00                                       
                                                  pop r1
                                                  print(r1)
                                                  free(r1)
1c 00 00 00                                       
                                                  ret
