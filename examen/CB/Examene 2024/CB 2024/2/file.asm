section .data
	v dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 0
	dest dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 0
	fmt_nl db 10, 0
	fmt_s db "%s", 10, 0
	fmt_int db "%d", 0
	fmt_int_space db "%d ", 0
	string db "STRIng", 0

section .text
extern strlen
extern printf
extern scanf
extern memset

global main

; TODO: a: Implement `void reset_arr(int *n, int *v)
reset_arr:
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8] ; *n
	mov ebx, [ebp + 12] ; v
	
	pusha
    push eax
    push fmt_int
    call scanf
    add esp, 8
    popa

	; void *memset(void *ptr, int x, size_t n);
	pusha
	mov edx, [eax]
	imul edx, 4  ; 4 = sizeof(int)
	push edx
	push 0
	push ebx
	call memset
	add esp, 12
	popa

	leave
	ret

; TODO: b: Implement `int dup_array(int n, int *src, int *dest)
dup_array:
	push ebp
	mov ebp, esp

	mov ebx, [ebp + 8]  ; n
	mov ecx, [ebp + 12] ; src
	mov edx, [ebp + 16] ; dest
	xor eax, eax

	xor esi, esi ; idx src
loop_dup:
	cmp esi, ebx
	jge end_loop_dup

	mov edi, [ecx + 4 * esi]
	cmp edi, 0
	je next_iter_dup
	mov [edx + 4 * eax], edi 
	inc eax

next_iter_dup:
	inc esi
	jmp loop_dup

end_loop_dup:

	leave
	ret

; TODO: c: Implement `to_lower(int n, char *c)`, that converts
; uppercase letters to lowercase.
to_lower:
	push ebp
	mov ebp, esp

	mov esi, [ebp + 8]

	push esi
	call strlen
	add esp, 4

	dec eax  ; strlen - 1
	xor ecx, ecx ; idx

loop_lower:
	cmp ecx, eax
	jge end_lwr_loop

	mov bl, byte [esi + ecx]
    cmp bl, 'A'
    jb next_iter_lwr
    cmp bl, 'Z'
    ja next_iter_lwr
	add bl, 32
	mov byte [esi + ecx], bl

next_iter_lwr:
	inc ecx
	jmp loop_lower

end_lwr_loop:

	leave
	ret

main:
    push ebp
    mov ebp, esp

; TODO: a: Call reset_arr
	sub esp, 4
	push v
	push esp 
	call reset_arr
	add esp, 8

; TODO: a: Print array
	push v
	push 10
	call print_array
	add esp, 8

	push fmt_nl
    call printf
    add esp, 4

; TODO: b: Call dup_array
	push dest
	push v
	push 10
	call dup_array
	add esp, 12
; TODO: b: Print dest array
	push dest
	push eax
	call print_array
	add esp, 8

	push fmt_nl
    call printf
    add esp, 4

; TODO c: Call to_lower and print the string
	push string
	call to_lower
	add esp, 4

	push string
	push fmt_s
	call printf
	add esp, 8

	; Return 0.
	xor eax, eax
	leave
	ret

print_array:
    push ebp
    mov ebp, esp

    mov ecx, [ebp + 8]
    mov ebx, [ebp + 12]

    xor eax, eax
loop6:
    cmp eax, ecx
    jge end_loop6

    mov edx, [ebx + 4 * eax]

    pusha
    push edx
    push fmt_int_space
    call printf
    add esp, 8
    popa

    inc eax
    jmp loop6

end_loop6:

    leave
    ret
