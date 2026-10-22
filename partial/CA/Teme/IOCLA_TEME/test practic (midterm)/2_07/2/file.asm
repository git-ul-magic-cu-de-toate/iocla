%include "printf32.asm"

section .rodata
	int_fmt db "%d", 10, 0

section .data
	question db "Do YoU wATn to PLaY a GAme?", 0
	question_len equ $-question
	arr dd 123, 456, 789, 101112, 131415
	arr_len equ $-arr

; section .text

; void sum_digits(int *)
extern sum_digits
extern puts
extern printf
global main

transform_string:
	push ebp
	mov ebp, esp

	; TODO 1: Transform lowercase characters into digits of value:
	; question[i] = question[i] % 8 + '0', where c is the ascii value of the character
	; test using question
	xor ecx, ecx
	xor eax, eax

loop_begin:
	cmp ecx, question_len
	je loop_end

	mov al, [question + ecx]

	cmp eax, 97
	jl skip

	cmp eax, 122
	jg skip

	; perform transformation
	mov ebx, 8
	div ebx
	mov eax, edx
	add eax, 48
	mov [question + ecx], eax
skip:

	inc ecx
	jmp loop_begin

loop_end:

	PRINTF32 `[PRINTF32]: %s\n[PUTS]: \x0`, question

    push question
    call puts
    add esp, 4

	leave
	ret

; void apply_digit_sum(int *arr, int size)
apply_digit_sum:
	push ebp
	mov ebp, esp

	; TODO 2: Apply the sum_digits function to each element of the array

	leave
	ret


global main
main:
	push ebp
	mov ebp, esp

	; TODO 1: Call transform_string using the `question` string
	push transform_string

	; TODO 2: Call apply_digit_sum using the `arr` array

	; TODO 3: Allocate a 5 integer array on the stack and call sum_digits on it
	; print out the elements of the array using printf

	leave
	ret
