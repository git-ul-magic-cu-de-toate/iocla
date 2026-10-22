%include "./utils/printf32.asm"

extern printf

section .bss:
	; structura pentru o bautura
	struc beverage_t
		.strength:	resd	1	; tarie bautura <0-100>
		name:		resb	10	; char[10] - nume bautura
		quantity:	resd	1	; integer - cantitate detinuta
		shelf_id:	resd	1	; integer - raftul pe care se gaseste bautura <index in v_shelves>
	endstruc

	; structura pentru un raft din magazin
	struc shelf_t
		.strength:	resd	1	; taria totala gasita pe acel raft
		aisle:		resb	10	; char[10] - nume raion reprezentat de acel raft
	endstruc

section .data
	fmt_int db "%d ", 0
	fmt_name dw "%s ", 0
	v_shelves_count:	dd 3
	v_beverages_count:	dd 5

	v_shelves:
		istruc shelf_t
			at shelf_t.strength,	dd 0
			at aisle,				db "Deadly", 0
		iend

		istruc shelf_t
			at shelf_t.strength,	dd 0
			at aisle,				db "Spirits", 0
		iend

		istruc shelf_t
			at shelf_t.strength,	dd 0
			at aisle,				db "Apetisers", 0
		iend

	v_beverages:
		istruc beverage_t
			at beverage_t.strength,		dd 70
			at name,					db "Absinth", 0
			at quantity,				dd 20
			at shelf_id,				dd 0
		iend

		istruc beverage_t
			at beverage_t.strength,		dd 7
			at name,					db "Beer", 0
			at quantity,				dd 50
			at shelf_id,				dd 2
		iend

		istruc beverage_t
			at beverage_t.strength,		dd 40
			at name,					db "Rum", 0
			at quantity,				dd 30
			at shelf_id,				dd 1
		iend

		istruc beverage_t
			at beverage_t.strength,		dd 35
			at name,					db "Whiskey", 0
			at quantity,				dd 35
			at shelf_id,				dd 1
		iend

		istruc beverage_t
			at beverage_t.strength,		dd 7
			at name,					db "Cider", 0
			at quantity,				dd 45
			at shelf_id,				dd 2
		iend



section .text
global main

main:
	push ebp
	mov ebp, esp

	;; Freestyle starts here

	PRINTF32 `Here comes a)\n\n\x0`

	; TODO a: TODO

	mov esi, v_beverages
	mov edi, [v_beverages_count]
	xor ecx, ecx

loop_a:
	cmp ecx, edi
	je end_a

	lea edx, [esi + name]

	push esi
	push edi
	push ecx

	push edx
	push fmt_name
	call printf
	add esp, 8

	PRINTF32 `\n\x0`

	pop ecx
	pop edi
	pop esi

	inc ecx
	add esi, 22
	jmp loop_a

end_a:

	PRINTF32 `\nHere comes b)\n\n\x0`

	; TODO b: TODO
	xor eax, eax
	xor ebx, ebx

	mov esi, v_beverages
	mov edi, [v_beverages_count]
	xor ecx, ecx

loop_b:
	cmp ecx, edi
	je end_b

	lea edx, [esi + 4]

	push esi
	push edi
	push ecx

	push edx
	push fmt_name
	call printf
	add esp, 8

	pop ecx
	pop edi
	pop esi

	mov ebx, [esi + shelf_id]

	cmp ebx, 0
	je deadly

	cmp ebx, 1
	je spirits

	PRINTF32 `Apetisers\n\x0`
	inc ecx
	add esi, 22
	jmp loop_b

deadly:
	PRINTF32 `Deadly\n\x0`
	inc ecx
	add esi, 22
	jmp loop_b

spirits:
	PRINTF32 `Spirits\n\x0`
	inc ecx
	add esi, 22
	jmp loop_b

end_b:

	PRINTF32 `\nHere comes c)\n\n\x0`

	; TODO c: TODO
	mov esi, v_shelves
	mov edi, [v_shelves_count]
	xor ecx, ecx
	xor edx, edx

loop_c:
	cmp ecx, edi
	je end_c

	lea edx, [esi + aisle]

	push esi
	push edi
	push ecx
	
	push edx
	push fmt_name
	call printf
	add esp, 8

	PRINTF32 `\n\x0`

	pop ecx
	pop edi
	pop esi

	inc ecx
	add esi, 14
	jmp loop_c

end_c:

	PRINTF32 `\nHere comes d)\n\n\x0`

	; TODO d: TODO

	mov esi, v_shelves
	mov edi, [v_shelves_count]
	xor ecx, ecx
	xor edx, edx

loop_d:
	cmp ecx, edi
	je end_d

	lea edx, [esi + aisle]

	push esi
	push edi
	push ecx
	
	push edx
	push fmt_name
	call printf
	add esp, 8

	PRINTF32 `\n\x0`

	pop ecx
	pop edi
	pop esi

	inc ecx
	add esi, 14
	jmp loop_d

end_d:

	;; Freestyle ends here

	; Return 0.
	xor eax, eax
	leave
	ret
