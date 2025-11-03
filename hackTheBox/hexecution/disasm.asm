	mov r6_carbo, 0x0
	push 0x45   ; 'E'
	push 0x6e   ; 'n'
	push 0x74   ; 't'
	push 0x65   ; 'e'
	push 0x72   ; 'r'
	push 0x20   ; ' '
	push 0x74   ; 't'
	push 0x68   ; 'h'
	push 0x65   ; 'e'
	push 0x20   ; ' '
	push 0x66   ; 'f'
	push 0x6c   ; 'l'
	push 0x61   ; 'a'
	push 0x67   ; 'g'
	push 0x3a   ; ':'
	push 0x20   ; ' '
	mov r6_carbo, 0x0
	mov r5_protein, 0x10
	spell(1, r6_carbo, r5_protein)    ; write(1, buffer[r6_carbo], r5_protein)

    ; buffer[0..0x10]: 'Enter the flag: '
    ; --
    ; buffer[0x100]: 0x10

	xor r5_protein, r5_protein
	xor r6_carbo, r6_carbo
	mov r6_carbo, 0x14
	spell(0, r6_carbo, r5_protein)    ; read(0, buf[r6_carbo], MAX_SIZE)

    ; buffer[0..0x10]: 'Enter the flag: '
    ; buffer[0x10..0x14]: 0
    ; buffer[0x14..0x34]: flag
    ; buffer[0x35]: '\n'
    ; buffer[0x36]: strlen(flag)
    ; --
    ; buffer[0x100]: 0x30

	mov r6_carbo, 0x40
	push 0x35   ; '5'
	push 0x6d   ; 'm'
	push 0x61   ; 'a'
	push 0x4e   ; 'N'
	push 0x63   ; 'c'
	push 0x49   ; 'I'
	push 0x34   ; '4'
	push 0x5f   ; '_'
	push 0x5f   ; '_'
	push 0x55   ; 'U'
	push 0x31   ; '1'
	push 0x30   ; '0'
	push 0x5f   ; '_'
	push 0x64   ; 'd'
	push 0x65   ; 'e'
	push 0x35   ; '5'
	push 0x4c   ; 'L'
	push 0x31   ; '1'
	push 0x33   ; '3'
	push 0x5f   ; '_'
	push 0x4d   ; 'M'
	push 0x6e   ; 'n'
	push 0x34   ; '4'
	push 0x55   ; 'U'
	push 0x30   ; '0'
	push 0x75   ; 'u'
	push 0x34   ; '4'
	push 0x74   ; 't'
	push 0x72   ; 'r'
	push 0x66   ; 'f'
	push 0x6e   ; 'n'
	push 0x5f   ; '_'

	; buffer[0..0x10]: 'Enter the flag: '
    ; buffer[0x10..0x14]: 0
    ; buffer[0x14..0x34]: flag
    ; buffer[0x35]: '\n'
    ; buffer[0x36]: strlen(flag)
    ; buffer[0x36..0x40]: 0
    ; buffer[0x70..0x90]: encrypted flag
    ; --
    ; buffer[0x100]: 0x50

	mov r5_protein, buffer[0x36] ; strlen(flag)
	mov r1_vegetable, 0x20
	cmp r5_protein, r1_vegetable

    ; First round

	mov r5_protein, buffer[0x14]
	mov r1_vegetable, r5_protein
	mov r5_protein, buffer[0x15]
	mov r2_fruit, r5_protein
	mov r5_protein, buffer[0x16]
	mov r3_meat, r5_protein
	mov r5_protein, buffer[0x17]
	mov r4_dairy, r5_protein
	mov r6_carbo, 0x14
	mov buffer[reg6_carbo], r3_meat
	mov r6_carbo, 0x15
	mov buffer[reg6_carbo], r2_fruit
	mov r6_carbo, 0x16
	mov buffer[reg6_carbo], r4_dairy
	mov r6_carbo, 0x17
	mov buffer[reg6_carbo], r1_vegetable

	mov r5_protein, buffer[0x18]
	mov r1_vegetable, r5_protein
	mov r5_protein, buffer[0x19]
	mov r2_fruit, r5_protein
	mov r5_protein, buffer[0x1a]
	mov r3_meat, r5_protein
	mov r5_protein, buffer[0x1b]
	mov r4_dairy, r5_protein
	mov r6_carbo, 0x18
	mov buffer[reg6_carbo], r3_meat
	mov r6_carbo, 0x19
	mov buffer[reg6_carbo], r2_fruit
	mov r6_carbo, 0x1a
	mov buffer[reg6_carbo], r4_dairy
	mov r6_carbo, 0x1b
	mov buffer[reg6_carbo], r1_vegetable

	mov r5_protein, buffer[0x1c]
	mov r1_vegetable, r5_protein
	mov r5_protein, buffer[0x1d]
	mov r2_fruit, r5_protein
	mov r5_protein, buffer[0x1e]
	mov r3_meat, r5_protein
	mov r5_protein, buffer[0x1f]
	mov r4_dairy, r5_protein
	mov r6_carbo, 0x1c
	mov buffer[reg6_carbo], r3_meat
	mov r6_carbo, 0x1d
	mov buffer[reg6_carbo], r2_fruit
	mov r6_carbo, 0x1e
	mov buffer[reg6_carbo], r4_dairy
	mov r6_carbo, 0x1f
	mov buffer[reg6_carbo], r1_vegetable

	mov r5_protein, buffer[0x20]
	mov r1_vegetable, r5_protein
	mov r5_protein, buffer[0x21]
	mov r2_fruit, r5_protein
	mov r5_protein, buffer[0x22]
	mov r3_meat, r5_protein
	mov r5_protein, buffer[0x23]
	mov r4_dairy, r5_protein
	mov r6_carbo, 0x20
	mov buffer[reg6_carbo], r3_meat
	mov r6_carbo, 0x21
	mov buffer[reg6_carbo], r2_fruit
	mov r6_carbo, 0x22
	mov buffer[reg6_carbo], r4_dairy
	mov r6_carbo, 0x23
	mov buffer[reg6_carbo], r1_vegetable

	mov r5_protein, buffer[0x24]
	mov r1_vegetable, r5_protein
	mov r5_protein, buffer[0x25]
	mov r2_fruit, r5_protein
	mov r5_protein, buffer[0x26]
	mov r3_meat, r5_protein
	mov r5_protein, buffer[0x27]
	mov r4_dairy, r5_protein
	mov r6_carbo, 0x24
	mov buffer[reg6_carbo], r3_meat
	mov r6_carbo, 0x25
	mov buffer[reg6_carbo], r2_fruit
	mov r6_carbo, 0x26
	mov buffer[reg6_carbo], r4_dairy
	mov r6_carbo, 0x27
	mov buffer[reg6_carbo], r1_vegetable

	mov r5_protein, buffer[0x28]
	mov r1_vegetable, r5_protein
	mov r5_protein, buffer[0x29]
	mov r2_fruit, r5_protein
	mov r5_protein, buffer[0x2a]
	mov r3_meat, r5_protein
	mov r5_protein, buffer[0x2b]
	mov r4_dairy, r5_protein
	mov r6_carbo, 0x28
	mov buffer[reg6_carbo], r3_meat
	mov r6_carbo, 0x29
	mov buffer[reg6_carbo], r2_fruit
	mov r6_carbo, 0x2a
	mov buffer[reg6_carbo], r4_dairy
	mov r6_carbo, 0x2b
	mov buffer[reg6_carbo], r1_vegetable

	mov r5_protein, buffer[0x2c]
	mov r1_vegetable, r5_protein
	mov r5_protein, buffer[0x2d]
	mov r2_fruit, r5_protein
	mov r5_protein, buffer[0x2e]
	mov r3_meat, r5_protein
	mov r5_protein, buffer[0x2f]
	mov r4_dairy, r5_protein
	mov r6_carbo, 0x2c
	mov buffer[reg6_carbo], r3_meat
	mov r6_carbo, 0x2d
	mov buffer[reg6_carbo], r2_fruit
	mov r6_carbo, 0x2e
	mov buffer[reg6_carbo], r4_dairy
	mov r6_carbo, 0x2f
	mov buffer[reg6_carbo], r1_vegetable

	mov r5_protein, buffer[0x30]
	mov r1_vegetable, r5_protein
	mov r5_protein, buffer[0x31]
	mov r2_fruit, r5_protein
	mov r5_protein, buffer[0x32]
	mov r3_meat, r5_protein
	mov r5_protein, buffer[0x33]
	mov r4_dairy, r5_protein
	mov r6_carbo, 0x30
	mov buffer[reg6_carbo], r3_meat
	mov r6_carbo, 0x31
	mov buffer[reg6_carbo], r2_fruit
	mov r6_carbo, 0x32
	mov buffer[reg6_carbo], r4_dairy
	mov r6_carbo, 0x33
	mov buffer[reg6_carbo], r1_vegetable


	; buffer[0..0x10]: 'Enter the flag: '
    ; buffer[0x10..0x14]: 0
    ; buffer[0x14..0x34]: flag
    ; buffer[0x35]: '\n'
    ; buffer[0x36]: strlen(flag)
    ; buffer[0x36..0x40]: 0
    ; buffer[0x70..0x90]: encrypted flag
    ; --
    ; buffer[0x100]: 0x50

    ; Second round

	mov r6_carbo, 0x42
	mov r5_protein, buffer[0x14]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x19]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x1e]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x23]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x17]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x1a]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x1d]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x20]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x18]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x15]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x16]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x1b]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x1c]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x21]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x22]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x1f]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x24]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x29]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x2e]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x33]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x27]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x2a]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x2d]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x30]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x28]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x25]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x26]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x2b]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x2c]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x31]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x32]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo
	mov r5_protein, buffer[0x2f]
	mov buffer[reg6_carbo], r5_protein
	inc r6_carbo

	; buffer[0..0x10]: 'Enter the flag: '
    ; buffer[0x10..0x14]: 0
    ; buffer[0x14..0x34]: flag
    ; buffer[0x35]: '\n'
    ; buffer[0x36]: strlen(flag)
    ; buffer[0x36..0x42]: 0
    ; buffer[0x42..0x62]: modified flag
    ; buffer[0x70..0x90]: encrypted flag
    ; --
    ; buffer[0x100]: 0x50

	buffer_dump_num

	mov r5_protein, 0x42
	mov r6_carbo, 0x70
	strcmp(buffer[r5_protein], buffer[r6_carbo])
