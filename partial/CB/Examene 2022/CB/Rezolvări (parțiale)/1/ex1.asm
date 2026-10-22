%include "printf32.asm"
extern printf

section .bss
	product_answer resw 1
	answer resb 24

section .data
	playlist db 0x42, 0x75, 0x76, 0x45, 0x25, 0x79, 0x54, 0x62, 0x94, 0x35, 0x6D, 0x6E, 0x45, 0x4D, 0x7A, 0x14, 0x25, 0x57, 0x94, 0x4C, 0x55, 0x42, 0x78, 0x4B
	playlist_len equ 24

	answer_len equ 12

section .text
global main

main:
    push ebp
    mov ebp, esp


    ; TODO a:
	; Faceti produsul dintre numarul de caractere din vector mai mici decat 'K'
	; si cel al caracterelor mai mari sau egale decat 'K'.
	; Puneti in product_answer rezultatul. (ATENTIE! product_answer asteapta
	; un word (short).

	xor ecx, ecx
	xor eax, eax ; < K
	xor ebx, ebx ; >= K
	xor edx, edx
	mov esi, playlist_len

search_for_K:
	cmp ecx, esi
	je calc_product

	mov dl, [playlist + ecx]
	cmp edx, 0x4B
	jge more_or_equal_K

	inc eax
	inc ecx
	jmp search_for_K

more_or_equal_K:
	inc ebx
	inc ecx
	jmp search_for_K

calc_product:
	mul ebx
	mov [product_answer], ax

	; Instructiune de afisare! NU MODIFICATI!
	a_print:
	PRINTF32 `%d\n\x0`, [product_answer]


    ; TODO b:
	; Pentru fiecare element din playlist, puneti in vectorul answer restul
	; impartirii lui la 41.
	
	xor ecx, ecx
	xor eax, eax
	xor ebx, ebx
	xor edx, edx
	xor esi, esi ; contor pentru loop la b)
	xor edi, edi

b_loop:
	cmp esi, playlist_len
	je b_print

	xor eax, eax
	xor edx, edx

	mov al, [playlist + esi]
	mov cl, 41
	div ecx
	mov [answer + esi], dl
	
	inc esi
	jmp b_loop

	; Instructiune de afisare! NU MODIFICATI!
b_print:
	xor ecx, ecx
b_print_loop:
	PRINTF32 `%hhd \x0`, [answer + ecx]
	inc ecx
	cmp ecx, playlist_len
	jb b_print_loop
	PRINTF32 `\n\x0`


    ; TODO c:
	; Pentru elementele de pe indici multiplii de 3 sau de 4, inversati
	; nibbles. Fiecare rezultat va fi pus in vectorul answer.

	xor ecx, ecx
	xor eax, eax
	xor ebx, ebx
	xor edx, edx
	xor esi, esi 
	xor edi, edi

loop_c:
	cmp ecx, playlist_len
	je c_print

	mov eax, ecx
	mov ebx, 3
	xor edx, edx
	div ebx
	cmp edx, 0
	je switch

	mov eax, ecx
	mov ebx, 4
	xor edx, edx
	div ebx
	cmp edx, 0
	je switch

	inc ecx
	jmp loop_c

switch:
	xor ebx, ebx
	mov bl, [playlist + ecx]
	rol bl, 4
	mov [answer + edi], bl
	inc edi
	inc ecx
	jmp loop_c

	; Instructiune de afisare! NU MODIFICATI!
c_print:
	xor ecx, ecx

c_print_loop:
	PRINTF32 `%c\x0`, [answer + ecx]
	inc ecx
	cmp ecx, answer_len
	jb c_print_loop
	PRINTF32 `\n\x0`

    ; Return 0.
    xor eax, eax
    leave
    ret
