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
	xor eax, eax
	lea eax, [v_beverages + 0 * beverage_t_size + name] 
	PRINTF32 `%s \x0`, eax
	PRINTF32 `\n\x0`

	lea eax, [v_beverages + 1 * beverage_t_size + name] 
	PRINTF32 `%s \x0`, eax
	PRINTF32 `\n\x0`

	lea eax, [v_beverages + 2 * beverage_t_size + name] 
	PRINTF32 `%s \x0`, eax
	PRINTF32 `\n\x0`

	lea eax, [v_beverages + 3 * beverage_t_size + name] 
	PRINTF32 `%s \x0`, eax
	PRINTF32 `\n\x0`

	lea eax, [v_beverages + 4 * beverage_t_size + name] 
	PRINTF32 `%s \x0`, eax
	PRINTF32 `\n\x0`
	
	
	PRINTF32 `\nHere comes b)\n\n\x0`

	; TODO b: TODO
	xor eax, eax
	xor ebx, ebx
	lea eax, [v_beverages + 0 * beverage_t_size + name] 
	PRINTF32 `%s \x0`, eax
	lea ebx, [v_shelves +   0 * shelf_t_size + aisle]
	PRINTF32 `%s \x0`, ebx
	PRINTF32 `\n\x0`

	xor eax, eax
	xor ebx, ebx
	lea eax, [v_beverages + 1 * beverage_t_size + name] 
	PRINTF32 `%s \x0`, eax
	lea ebx, [v_shelves +   2 * shelf_t_size + aisle]
	PRINTF32 `%s \x0`, ebx
	PRINTF32 `\n\x0`

	xor eax, eax
	xor ebx, ebx
	lea eax, [v_beverages + 2 * beverage_t_size + name] 
	PRINTF32 `%s \x0`, eax
	lea ebx, [v_shelves +   1 * shelf_t_size + aisle]
	PRINTF32 `%s \x0`, ebx
	PRINTF32 `\n\x0`

	xor eax, eax
	xor ebx, ebx
	lea eax, [v_beverages + 3 * beverage_t_size + name] 
	PRINTF32 `%s \x0`, eax
	lea ebx, [v_shelves +   1 * shelf_t_size + aisle]
	PRINTF32 `%s \x0`, ebx
	PRINTF32 `\n\x0`

	xor eax, eax
	xor ebx, ebx
	lea eax, [v_beverages + 4 * beverage_t_size + name] 
	PRINTF32 `%s \x0`, eax
	lea ebx, [v_shelves +   2 * shelf_t_size + aisle]
	PRINTF32 `%s \x0`, ebx
	PRINTF32 `\n\x0`
	

	PRINTF32 `\nHere comes c)\n\n\x0`

	lea ebx, [v_shelves +   0 * shelf_t_size + aisle]
	PRINTF32 `%s \x0`, ebx
	PRINTF32 `\n\x0`

	lea ebx, [v_shelves +   1 * shelf_t_size + aisle]
	PRINTF32 `%s \x0`, ebx
	PRINTF32 `\n\x0`

	lea ebx, [v_shelves +   2 * shelf_t_size + aisle]
	PRINTF32 `%s \x0`, ebx
	PRINTF32 `\n\x0`

	; TODO c: TODO
	PRINTF32 `\nHere comes d)\n\n\x0`
	xor ebx,ebx
	lea ebx, [v_shelves +   0 * shelf_t_size + aisle]
	PRINTF32 `%s \x0`, ebx
	mov eax, [v_beverages + 0 * beverage_t_size + beverage_t.strength]
	mul [v_beverages + 0 * beverage_t_size + quantity]
	PRINTF32 ` adsa\x0`

	

	; TODO d: TODO
	
	


	;; Freestyle ends here

	; Return 0.
	xor eax, eax
	leave
	ret
