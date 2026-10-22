extern puts
extern printf

section .rodata
    format db "%u ", 0
    puts_format db "", 0
    newline: db 10, 0

section .data
    arr1 dd 10, 20, 30, 40, 50, 60, 70, 80, 11, 22, 33, 44, 55, 66, 77, 88, 99
    ; b) c) Test with k = 1, 7, 0, 17, 18
    len1 equ 17
    k equ 17

section .bss
    dest resd 100

section .text
global main

elem_adj:
    push ebp
    mov ebp, esp
    pusha
    ; TODO b: Implement adjacent computing function:
    ; elem_adj(unsigned int len, int k, unsigned int *v, unsigned int *w)
    mov eax, [ebp + 8] ; len
    mov ebx, [ebp + 12] ; k
    mov ecx, [ebp + 16] ; v
    mov edx, [ebp + 20] ; w

    cmp ebx, eax
    jg end_rnadom
    jl label_random
    dec eax
    dec ebx
    mov esi, [ecx + 4 * eax]
    mov edi, [ecx]
    imul edi, esi
    mov dword [edx + 4 * ebx], edi
    dec ebx

    push esi
    push format
    call printf
    add esp, 8

    push edi
    push format
    call printf
    add esp, 8

label_random:

end_rnadom:
    popa
    leave
    ret

elem_inplace:
    push ebp
    mov ebp, esp

    ; TODO c: Implement inplace computing function:
    ; elem_inplace(unsigned int len, int k, unsigned int *v)

    leave
    ret

print_arr:
    push ebp
    mov ebp, esp

    ; TODO a: Implement array printing function:
    ; print_v(unsigned int len, unsigned int *v);
    mov ecx, [ebp + 8]
    mov ebx, [ebp + 12]

    xor eax, eax
loop6:
    cmp eax, ecx
    jge end_loop6

    mov edx, [ebx + 4 * eax]

    pusha
    push edx
    push format
    call printf
    add esp, 8
    popa

    inc eax
    jmp loop6

end_loop6:
    leave
    ret


main:
    push ebp
    mov ebp, esp


    ; Print arr1 using print_arr.
    lea eax, [arr1]
    lea ebx, [dest]

    push eax
    push len1
    call print_arr
    add esp, 8

    push newline
    call printf
    add esp, 4

    ; Compute elems in dest using elem_adj.
    push dest
    push arr1
    push k
    push len1
    call elem_adj
    add esp, 16

    ; Print dest using print_arr.
    push ebx
    push len1
    call print_arr
    add esp, 8

    push newline
    call printf
    add esp, 4

    ; Compute elem_inplace in arr1.

    ; Print arr1 using print_arr.

    ; Return 0.
    xor eax, eax
    leave
    ret
