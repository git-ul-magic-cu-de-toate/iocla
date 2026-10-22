%include "printf32.asm"
extern printf

section .bss
	product_answer resw 1
	answer resb 24

section .data
	playlist db 0x42, 0x75, 0x76, 0x45, 0x25, 0x79, 0x54, 0x62, 0x94, 0x35, 0x6D, 0x6E, 0x45, 0x4D, 0x7A, 0x14, 0x25, 0x57, 0x94, 0x4C, 0x55, 0x42, 0x78, 0x4B
	playlist_len equ 24

	answer_len equ 12

; playlist -> 0x42
; playlist + 1 -> 0x75 ...

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
	xor ecx, ecx ; contor
	xor eax, eax ; mai mici decat K
	xor ebx, ebx ; mai mari sau egale decat K

	; for i = 0; i < playlist_len; i++
playlist_loop:
	xor edx, edx
	mov dl, BYTE[playlist + ecx]

	cmp edx, 'K'
	jl lesser

greater:
	inc ebx
	jmp next_song

lesser:
	inc eax
	jmp next_song

next_song:
	inc ecx
	cmp ecx, playlist_len
	jl playlist_loop

	mul bx

	mov [product_answer], ax

	; Instructiune de afisare! NU MODIFICATI!
	a_print:
	PRINTF32 `%d\n\x0`, [product_answer]


    ; TODO b:
	; Pentru fiecare element din playlist, puneti in vectorul answer restul
	; impartirii lui la 41.
	xor ecx, ecx ; contor

divide:
	xor edx, edx
	xor eax, eax
	mov al, BYTE[playlist + ecx]

	mov ebx, 41

	idiv ebx

	mov BYTE [answer + ecx], dl

	inc ecx
	cmp ecx, playlist_len
	jl divide


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
	xor ecx, ecx ; contor
	xor edi, edi ; contor answer

reverse:
	xor edx, edx
	xor eax, eax
	mov al, cl

	mov ebx, 3

	idiv ebx

	cmp edx, 0
	je rev_nibble



	xor edx, edx
	xor eax, eax
	mov al, cl

	mov ebx, 4

	idiv ebx

	cmp edx, 0
	je rev_nibble

	jmp skip

rev_nibble:
	; 0b1010 0101

	; 0b1010 0101 >> 4 == 0b0000 1010
	; 0b1010 0101 << 4 == 0b0101 0000 -> OR = 0b0101 1010
	xor eax, eax
	xor edx, edx

	mov al, [playlist + ecx]
	mov dl, al

	shr eax, 4
	shl edx, 4

	or eax, edx

	mov [answer + edi], al
	inc edi

skip:
	inc ecx
	cmp ecx, playlist_len
	jl reverse

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
