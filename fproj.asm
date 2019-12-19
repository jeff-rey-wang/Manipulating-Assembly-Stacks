
%include "simple_io.inc"
global asm_main
extern rperm

section .data

	array:		dq 1,2,3,4,5,6,7,8
	prompt1:	db "enter a,b to swap",10,0
	prompt2: 	db "0 to terminate: ",0
	a1: 		db "first value not 1..8",10,0
	a2: 		db "comma missing",10,0
	a3: 		db "second value not 1..8",10,0

	spaces:		db "     ",0
	gap:			db "          ",0

	one_space:	db "1    ",0
	one_base:	db ".....+....",0

	two_space:	db "2    ",0
	two_roof:	db "     ++   ",0
	two_base:	db ".....++...",0

	three_space:	db "3    ",0
	three_roof:	db "    +-+   ",0
	three_wall:	db "    + +   ",0
	three_base:	db "....+-+...",0

	four_space:	db "4    ",0
	four_roof:	db "    +--+  ",0
	four_wall:	db "    +  +  ",0
	four_base:	db "....+--+..",0

	five_space:	db "5    ",0
	five_roof:	db "   +---+  ",0
	five_wall:	db "   +   +  ",0
	five_base:	db "...+---+..",0

	six_space:	db "6    ",0
	six_roof:	db "   +----+ ",0
	six_wall:	db "   +    + ",0
	six_base:	db "...+----+.",0

	seven_space:	db "7    ",0
	seven_roof:	db "  +-----+ ",0
	seven_wall:	db "  +     + ",0
	seven_base:	db "..+-----+.",0

	eight_space:	db "8    ",0
	eight_roof:	db "  +------+",0
	eight_wall:	db "  +      +",0
	eight_base:	db "..+------+",0

section .text

display:
	enter 0,0
	saveregs
	mov rbx, [rbp+24]
	mov rdx, [rbp+32]

	mov r15, rbx
	mov rcx, rdx
	mov r13, 0
	jmp LEVEL_LOOP

LEVEL_LOOP:
	mov r13, 0
	mov r15, rbx
	call print_nl
	cmp rcx, qword 1
	je reset_loop
	jmp ELEMENT_LOOP

ELEMENT_LOOP:
	cmp r13, rdx
	je dec_level
	cmp qword [r15], rcx
	jb print_gap
	cmp qword [r15], rcx
	je check_roof
	cmp qword [r15], rcx
	ja check_wall

dec_level:
	dec rcx
	jmp LEVEL_LOOP

reset_loop:
	cmp r13, rdx
	je prep_last
	cmp qword [r15], qword 1
	je print_one_base
	cmp qword [r15], qword 2
	je print_two_base
	cmp qword [r15], qword 3
	je print_three_base
	cmp qword [r15], qword 4
	je print_four_base
	cmp qword [r15], qword 5
	je print_five_base
	cmp qword [r15], qword 6
	je print_six_base
	cmp qword [r15], qword 7
	je print_seven_base
	cmp qword [r15], qword 8
	je print_eight_base
	jmp end_disp

prep_last:
	mov r13, 0
	mov r15, rbx
	call print_nl
	jmp print_lastline

print_lastline:
	mov rax, spaces
	call print_string
	cmp r13, rdx
	je end_disp
	cmp qword [r15], qword 1
	je print_one_space
	cmp qword [r15], qword 2
	je print_two_space
	cmp qword [r15], qword 3
	je print_three_space
	cmp qword [r15], qword 4
	je print_four_space
	cmp qword [r15], qword 5
	je print_five_space
	cmp qword [r15], qword 6
	je print_six_space
	cmp qword [r15], qword 7
	je print_seven_space
	cmp qword [r15], qword 8
	je print_eight_space
	jmp end_disp



print_one_space:
	mov rax, one_space
	call print_string
	add r15, 8
	add r13, qword 1
	jmp print_lastline

print_two_space:
	mov rax, two_space
	call print_string
	add r15, 8
	add r13, qword 1
	jmp print_lastline

print_three_space:
	mov rax, three_space
	call print_string
	add r15, 8
	add r13, qword 1
	jmp print_lastline

print_four_space:
	mov rax, four_space
	call print_string
	add r15, 8
	add r13, qword 1
	jmp print_lastline

print_five_space:
	mov rax, five_space
	call print_string
	add r15, 8
	add r13, qword 1
	jmp print_lastline

print_six_space:
	mov rax, six_space
	call print_string
	add r15, 8
	add r13, qword 1
	jmp print_lastline

print_seven_space:
	mov rax, seven_space
	call print_string
	add r15, 8
	add r13, qword 1
	jmp print_lastline

print_eight_space:
	mov rax, eight_space
	call print_string
	add r15, 8
	add r13, qword 1
	jmp print_lastline

check_roof:
	cmp qword [r15], qword 2
	je print_two_roof
	cmp qword [r15], qword 3
	je print_three_roof
	cmp qword [r15], qword 4
	je print_four_roof
	cmp qword [r15], qword 5
	je print_five_roof
	cmp qword [r15], qword 6
	je print_six_roof
	cmp qword [r15], qword 7
	je print_seven_roof
	cmp qword [r15], qword 8
	je print_eight_roof
	jmp end_disp

check_wall:
	cmp qword [r15], qword 3
	je print_three_wall
	cmp qword [r15], qword 4
	je print_four_wall
	cmp qword [r15], qword 5
	je print_five_wall
	cmp qword [r15], qword 6
	je print_six_wall
	cmp qword [r15], qword 7
	je print_seven_wall
	cmp qword [r15], qword 8
	je print_eight_wall
	jmp end_disp



print_gap:
	mov rax, gap
	call print_string
	add r15, 8
	add r13, qword 1
	jmp ELEMENT_LOOP

print_one_base:
	mov rax, one_base
	call print_string
	add r15, 8
	add r13, qword 1
	jmp reset_loop

print_two_roof:
	mov rax, two_roof
	call print_string
	add r15, 8
	add r13, qword 1
	jmp ELEMENT_LOOP

print_two_base:
	mov rax, two_base
	call print_string
	add r15, 8
	add r13, qword 1
	jmp reset_loop

print_three_roof:
	mov rax, three_roof
	call print_string
	add r15, 8
	add r13, qword 1
	jmp ELEMENT_LOOP

print_three_wall:
	mov rax, three_wall
	call print_string
	add r15, 8
	add r13, qword 1
	jmp ELEMENT_LOOP

print_three_base:
	mov rax, three_base
	call print_string
	add r15, 8
	add r13, qword 1
	jmp reset_loop

print_four_roof:
	mov rax, four_roof
	call print_string
	add r15, 8
	add r13, qword 1
	jmp ELEMENT_LOOP

print_four_wall:
	mov rax, four_wall
	call print_string
	add r15, 8
	add r13, qword 1
	jmp ELEMENT_LOOP

print_four_base:
	mov rax, four_base
	call print_string
	add r15, 8
	add r13, qword 1
	jmp reset_loop

print_five_roof:
	mov rax, five_roof
	call print_string
	add r15, 8
	add r13, qword 1
	jmp ELEMENT_LOOP

print_five_wall:
	mov rax, five_wall
	call print_string
	add r15, 8
	add r13, qword 1
	jmp ELEMENT_LOOP

print_five_base:
	mov rax, five_base
	call print_string
	add r15, 8
	add r13, qword 1
	jmp reset_loop

print_six_roof:
	mov rax, six_roof
	call print_string
	add r15, 8
	add r13, qword 1
	jmp ELEMENT_LOOP

print_six_wall:
	mov rax, six_wall
	call print_string
	add r15, 8
	add r13, qword 1
	jmp ELEMENT_LOOP

print_six_base:
	mov rax, six_base
	call print_string
	add r15, 8
	add r13, qword 1
	jmp reset_loop

print_seven_roof:
	mov rax, seven_roof
	call print_string
	add r15, 8
	add r13, qword 1
	jmp ELEMENT_LOOP

print_seven_wall:
	mov rax, seven_wall
	call print_string
	add r15, 8
	add r13, qword 1
	jmp ELEMENT_LOOP

print_seven_base:
	mov rax, seven_base
	call print_string
	add r15, 8
	add r13, qword 1
	jmp reset_loop

print_eight_roof:
	mov rax, eight_roof
	call print_string
	add r15, 8
	add r13, qword 1
	jmp ELEMENT_LOOP

print_eight_wall:
	mov rax, eight_wall
	call print_string
	add r15, 8
	add r13, qword 1
	jmp ELEMENT_LOOP

print_eight_base:
	mov rax, eight_base
	call print_string
	add r15, 8
	add r13, qword 1
	jmp reset_loop

end_disp:
	restoregs
	leave
	ret

asm_main:
	enter 0,0
	saveregs

	mov	rdi, array
	mov	rsi, 8

	call rperm

	push qword 8
	push array
	push qword 0
	call display
	pop rax
	pop rax
	pop rax

prompt:
	call	print_nl
	mov	rax, prompt1
	call	print_string
	mov	rax, prompt2
	call	print_string

read:
	call	read_char
	cmp	al, '0'
	je	asm_main_end
	cmp al, '1'
	jb error1
	cmp al, '8'
	ja error1

	mov r12, 0
	mov r12b, al
	sub r12b, '0'

	call read_char
	cmp al, ','
	jne error2

	call read_char
	cmp al, '1'
	jb error3
	cmp al, '8'
	ja error3

	mov r13, 0
	mov r13b, al
	sub r13b, '0'
	mov r14, array

READ_LOOP:
	call read_char
	cmp al, 10
	je	find_num1
	jmp READ_LOOP

find_num1:
	cmp [r14], r12
	je prep_num2
	add r14, 8
	jmp find_num1

prep_num2:
	mov r15, array

find_num2:
	cmp [r15], r13
	je save_num
	add r15, 8
	jmp find_num2

save_num:
	mov [r14], r13
	mov [r15], r12

	push qword 8
	push array
	push qword 0

	call display

	pop rax
	pop rax
	pop rax

	jmp prompt

error1:
	mov	rax, a1
	call	print_string
	jmp	prompt

error2:
	mov	rax, a2
	call	print_string
	jmp	prompt

error3:
	mov	rax, a3
	call	print_string
	jmp	prompt

asm_main_end:
	restoregs
	leave
	ret
