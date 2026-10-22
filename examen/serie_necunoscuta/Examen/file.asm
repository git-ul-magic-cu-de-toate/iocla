%include "./utils/printf32.asm"
extern printf

section .data
int_arr dd 11, 20, 39, 57, 99, 100, 88, 19, 29, 42
len equ 10
limit dd 3000

section .bss
; TODO a: Reserve space for an array of `len` integers. The array name is `res_arr`
res_arr resd 10

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Fill in the first `len` elements of `res_arr` using the following formula:
    ; res_arr[i] = 65 * int_arr[i] + 7
    ; Print res_arr with all elements on the same line separated by a space
    xor edx, edx
while:
    cmp edx, len
    jge end_while
    mov eax, [int_arr + 4 * edx]
    imul eax, 65
    add eax, 7
    mov [res_arr + 4 * edx], eax
    PRINTF32 `%d \x0`, eax
    inc edx
    jmp while
end_while:
    PRINTF32 `\n\x0`

    ; TODO b: Find the number of all the elements of `res_arr` that are strictly greater than `limit`
    xor edx, edx
    xor ebx, ebx
while2:
    cmp edx, len
    jge end_while2
    mov eax, [res_arr + 4 * edx]
    cmp eax, [limit]
    jle notgreater
    inc ebx
notgreater:
    inc edx
    jmp while2
end_while2:
    PRINTF32 `%d\n\x0`, ebx

    ; TODO c: Find the largest number from `res_arr` that is strictly smaller than `limit`
	xor edi, edi
	mov ecx, [limit]
	mov ebx, eax
while3:
	cmp edi, len
	jge end_while3
	mov eax, [res_arr + 4 * edx]
	cmp eax, ecx
	jge notsmaller
	cmp eax, ebx
	jle notgreater2
	mov ebx, eax
notgreater2:
notsmaller:	
	inc edi
	jmp while3
end_while3:
	PRINTF32 `%d\n\x0`, ebx

    ; Return 0.
    xor eax, eax
    leave
    ret
