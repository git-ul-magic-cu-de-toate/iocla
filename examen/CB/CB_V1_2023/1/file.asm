%include "utils/printf32.asm"

extern printf

section .bss:
	; structura pentru o bautura
	struc beverage_t
		id:			resd	1	; id bautura = index in v_beverages
		bvg_name:	resb	10	; char[10] - nume bautura
	endstruc

	; structura pentru un angajat
	struc emp_t
		emp_name:	resb	10	; char[10] - nume angajat
		bvg_id:		resd	1	; integer - bautura ceruta = index in v_beverages
		drinking:	resd	1	; "bool" - 1 daca va consuma alcool, 0 daca nu
	endstruc

section .data
	vanilla_text:		db "Vanilla", 0

	v_beverages_count:	dd 3
	v_emp_count:		dd 5

	v_beverages:
		istruc beverage_t
			at id,			dd 0
			at bvg_name,	db "Rum", 0
		iend

		istruc beverage_t
			at id,			dd 1
			at bvg_name,	db "Whiskey", 0
		iend

		istruc beverage_t
			at id,			dd 2
			at bvg_name,	db "Beer", 0
		iend

	v_emp:
		istruc emp_t
			at emp_name,	db "John", 0
			at bvg_id,		dd 0
			at drinking,	dd 1
		iend

		istruc emp_t
			at emp_name,	db "Mark", 0
			at bvg_id,		dd 1
			at drinking,	dd 1
		iend

		istruc emp_t
			at emp_name,	db "Maria", 0
			at bvg_id,		dd 1
			at drinking,	dd 1
		iend

		istruc emp_t
			at emp_name,	db "George", 0
			at bvg_id,		dd 2
			at drinking,	dd 1
		iend

		istruc emp_t
			at emp_name,	db "Elsa", 0
			at bvg_id,		dd 0
			at drinking,	dd 0
		iend

section .text
global main

main:
	push ebp
	mov ebp, esp

	;; Freestyle starts here

	PRINTF32 `Here comes a) and maybe c)\n\n\x0`

	; TODO a:	Print employee names from v_emp.
	mov ecx, v_emp
	xor eax, eax
loop1:
	cmp eax, [v_emp_count]
	jge end_loop1

	PRINTF32 `%s \x0`, ecx

	add ecx, 10
	; PRINTF32 `%d\n\x0`, dword [ecx]

	add ecx, 4
	cmp dword [ecx], 0
	jne sub1

	PRINTF32 `%s\n\x0`, vanilla_text
	sub ecx, 4
	jmp end_drink

sub1:
	sub ecx, 4
	mov esi, dword [ecx]
	mov edi, v_beverages
	mov edx, beverage_t_size
	imul esi, edx
	add edi, esi
	add edi, 4
	PRINTF32 `%s\n\x0`, edi

end_drink:
	add ecx, 8
	inc eax
	jmp loop1

end_loop1:
	PRINTF32 `\nHere comes b)\n\n\x0`

	; TODO b:	Print beverage names from v_beverages.
	mov ecx, v_beverages
	xor eax, eax
loop2:
	cmp eax, [v_beverages_count]
	jge end_loop2

	add ecx, 4

	PRINTF32 `%s \x0`, ecx

	add ecx, 10
	inc eax
	jmp loop2

end_loop2:
	PRINTF32 `\nHere comes c) or not xd\n\n\x0`

	; TODO c:	For each employee print their chosen drink or vanilla otherwise.
	; You can solve this task by modifying a) or below this comment.

	;; Freestyle ends here

	; Return 0.
	xor eax, eax
	leave
	ret
