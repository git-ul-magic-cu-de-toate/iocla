%include "../include/io.mac"

extern printf
global remove_numbers

section .data
	fmt db "%d", 10, 0

section .text

; function signature:
; void remove_numbers(int *a, int n, int *target, int *ptr_len);

remove_numbers:
	;; DO NOT MODIFY
	push    ebp
	mov     ebp, esp
	pusha

	mov     esi, [ebp + 8] ; source array
	mov     ebx, [ebp + 12] ; n
	mov     edi, [ebp + 16] ; dest array
	mov     edx, [ebp + 20] ; pointer to dest length

	;; DO NOT MODIFY


	;; Your code starts here

	xor  ecx, ecx 		; use to store no of accepted elements of dest array

						; I will use ebx as loop cnt
						; eax as a tmp register to hold the current number
						; and [edx] for power 2 check
loop_begin:
	cmp  ebx, 0
	jz   loop_end

	mov  eax, [esi] 	; load current elem in eax

						; check if power of 2
	mov  [edx], eax 	; use edx for power of 2 check
	dec  DWORD [edx]
	test eax, [edx]		; equivalent to [number & (number - 1)]
	jz   skip_elem

	test eax, 1			; check if even
	jz   is_even

	dec  ebx
	add  esi, 4 		; go to next elem in source array

	jmp  loop_begin

is_even:
	mov  [edi], eax 	; add eax to dest array
	add  edi, 4 		; point to next elem in dest array
	inc  ecx 			; inc no of elements in dest array
	dec  ebx
	add  esi, 4 		; go to next elem in source array
	jmp  loop_begin

skip_elem:
	dec  ebx
	add  esi, 4 		; go to next elem in source array
	jmp  loop_begin

loop_end:
	mov  [edx], ecx 	; store result len

	;; Your code ends here


	;; DO NOT MODIFY

	popa
	leave
	ret

	;; DO NOT MODIFY
