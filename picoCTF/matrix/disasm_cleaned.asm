_start:
	call print_welcome_message

	push 01		; coordX
	push 01		; coordY
	push 00		; health

get_next_char:
007B:
	call getc

	cmp r1, 0075 	; 'u'
	jz move_up

	cmp r1, 0064	; 'd'
	jz move_down

	cmp r1, 006C	; 'l'
	jz move_left

	cmp r1, 0072	; 'r'
	jz move_right

	call print_wrong_input
	jmp exit

move_up:
	sub [coordY], 1
	jmp calculate_position

get_char_d:
	add [coordY], 1
	jmp calculate_position

get_char_l:
	sub [coordX], 1
	jmp calculate_position

get_char_r:
	add [coordX], 1

calculate_position:
; main stack:
; [sp-6]:	coordX
; [sp-4]:	coordY
; [sp-2]:	health
;
; extra stack:

	; copy health and coordY to the extra stack
	push_e, [sp-2]
	push_e, [sp-4]

	mov [sp-2], calculate_row
	xchg [sp-2], [sp-4]
	push 0x10
	push 0x0

; main stack:
; [sp-10]:	coordX
; [sp-8]:	caltulate_row_ptr
; [sp-6]:	coordY
; [sp-4]:	0x10 (columns per row)
; [sp-2]:	0x0 (position)
;
; extra stack:
; [sp-4]: 	health
; [sp-2]:	coordY
calculate_column:
	; move the current position and "columns per row" const to the extra stack
	pop r1
	push_e r1
	pop r1
	push_e r1

	; check that coordY ([sp-2]) is zero, i.e. we have calculated all columns
	cmp [sp-2], 0x0
	jnz add_column_to_position
	jmp calculate_column_done

; main stack:
; [sp-6]:	coordX
; [sp-4]:	caltulate_row_ptr
; [sp-2]:	coordY
;
; extra stack:
; [sp-8]: 	health
; [sp-6]:	coordY
; [sp-4]:	position
; [sp-2]:	0x10 (columns per row)
add_column_to_position:
	sub [sp-2], 1

	; move 0x10 constant back to the main stack
	pop_e r1
	push r1

	; pop the current position, add 0x10 to it and move it to the main stack
	pop_e r2
	add r1, r2
	push r1

	jmp calulate_column

calculate_column_done:
; main stack:
; [sp-6]:	coordX
; [sp-4]:	caltulate_row_ptr
; [sp-2]:	coordY
;
; extra stack:
; [sp-8]: 	health
; [sp-6]:	coordY
; [sp-4]:	position
; [sp-2]:	0x10 (columns per row)

	; remove the 0x10 constant and the current position from the extra stack
	pop_e r1
	pop_e r1

	; remove coordY and calculate_row_ptr from the main stack
	pop r2
	pop r2

	; move the current position back to the main stack
	push r1

	; jmp to calculate_row
	; (in the original code it's in a different place, so the jump is really needed)
	jmp r2

calculate_row:
; main stack:
; [sp-4]:	coordX
; [sp-2]:	position
;
; extra stack:
; [sp-4]: 	health
; [sp-2]:	coordY

	; add coordX to the position, so now position is an index (not yet scaled) in the map array
	add [sp-2], [sp-4]

	; pop and save the position
	pop r1

	; move coordY and the health back to the main stack
	pop_e r2
	push r2
	pop_e r2
	push r2

	push calculate_map_offset
	push r1	; saved position
	push 2	; loop count


; main stack:
; [sp-12]:	coordX
; [sp-10]:	coordY
; [sp-8]:	health
; [sp-6]:	calculate_map_offset_ptr
; [sp-4]:	position
; [sp-2]:	loop counter
;
; extra stack:
scale_position_loop:
	; this loop multiplies the position by 4 because each map "value" is 4 bytes long
	; so in the end we have a real scaled index in the map array

	cmp [sp-2], 0
	jz scale_position_loop_done

	sub [sp-2], 1
	add [sp-4], [sp-4]
	jmp scale_position_loop

scale_position_loop_done:
	; remove the loop counter from the stack
	pop r1
	
	; pop calculate_map_offset ptr and jump to it
	; (in the original code it's in a different place, so jump is needed)
	xchg [sp-4], [sp-2]
	pop r1
	jmp r1


; main stack:
; [sp-8]:	coordX
; [sp-6]:	coordY
; [sp-4]:	health
; [sp-2]:	position
;
; extra stack:
calculate_map_offset:
	push get_next_char

	; add map offset to the position and jump to it
	xchg [sp-4], [sp-2]
	add [sp-2], map_offset
	pop r1
	jmp r1  ; jump to the calculated address which is one of the map cells

exit:
	mov r1, 1
	ret

print_loop:
	cmp [sp-2], 0
	jz print_loop_end

	pop r1
	call putc
	jmp print_loop

print_loop_end:
	pop	r1 ; remove '\0' from the stack
	ret

print_welcome_message:
	push 0000               ; '\0'
	push 000A               ; '\n'
	push 003F               ; '?'
	push 0065               ; 'e'
	push 0076               ; 'v'
	push 0069               ; 'i'
	push 006C               ; 'l'
	push 0061               ; 'a'
	push 0020               ; ' '
	push 0074               ; 't'
	push 0075               ; 'u'
	push 006F               ; 'o'
	push 0020               ; ' '
	push 0074               ; 't'
	push 0069               ; 'i'
	push 0020               ; ' '
	push 0065               ; 'e'
	push 006B               ; 'k'
	push 0061               ; 'a'
	push 006D               ; 'm'
	push 0020               ; ' '
	push 0075               ; 'u'
	push 006F               ; 'o'
	push 0079               ; 'y'
	push 0020               ; ' '
	push 006E               ; 'n'
	push 0061               ; 'a'
	push 0043               ; 'C'
	push 000A               ; '\n'
	push 0058               ; 'X'
	push 0020               ; ' '
	push 0049               ; 'I'
	push 0020               ; ' '
	push 0052               ; 'R'
	push 0020               ; ' '
	push 0054               ; 'T'
	push 0020               ; ' '
	push 0041               ; 'A'
	push 0020               ; ' '
	push 004D               ; 'M'
	push 0020               ; ' '
	push 0065               ; 'e'
	push 0068               ; 'h'
	push 0074               ; 't'
	push 0020               ; ' '
	push 006F               ; 'o'
	push 0074               ; 't'
	push 0020               ; ' '
	push 0065               ; 'e'
	push 006D               ; 'm'
	push 006F               ; 'o'
	push 0063               ; 'c'
	push 006C               ; 'l'
	push 0065               ; 'e'
	push 0057               ; 'W'
	jmp print_loop
	
print_wrong_input:
	push 0000               ; '\0'
	push 000A               ; '\n'
	push 002E               ; '.'
	push 0065               ; 'e'
	push 0075               ; 'u'
	push 0072               ; 'r'
	push 0067               ; 'g'
	push 0020               ; ' '
	push 0061               ; 'a'
	push 0020               ; ' '
	push 0079               ; 'y'
	push 0062               ; 'b'
	push 0020               ; ' '
	push 006E               ; 'n'
	push 0065               ; 'e'
	push 0074               ; 't'
	push 0061               ; 'a'
	push 0065               ; 'e'
	push 0020               ; ' '
	push 0065               ; 'e'
	push 0072               ; 'r'
	push 0065               ; 'e'
	push 0077               ; 'w'
	push 0020               ; ' '
	push 0075               ; 'u'
	push 006F               ; 'o'
	push 0059               ; 'Y'
	jmp print_loop

