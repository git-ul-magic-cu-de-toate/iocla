extern puts
extern printf

section .rodata
    format db "%u ", 0
    puts_format db "", 0

section .data
    arr1 dd 10, 20, 30, 40, 50, 60, 70, 80, 11, 22, 33, 44, 55, 66, 77, 88, 99
    ; b) c) Test with k = 1, 7, 0, 17, 18
    len1 equ 17
    k equ 1

section .bss
    dest resd 100

section .text
global main

elem_adj:
    push ebp
    mov ebp, esp

    ; TODO b: Implement adjacent computing function:
    ; elem_adj(unsigned int len, int k, unsigned int *v, unsigned int *w)

    push ebx
    push esi
    push edi


    

    pop edi
    pop esi
    pop ebx

    leave
    ret

elem_inplace:
    push ebp
    mov ebp, esp

    ; TODO c: Implement inplace computing function:
    ; elem_inplace(unsigned int len, int k, unsigned int *v)

    leave
    ret

print_v:
    push ebp
    mov ebp, esp

    push ebx
    push edi
    push esi

    mov esi, [ebp + 8]
    mov ebx, [ebp + 12]

    mov edi, 0

loop4:
    mov ebx, [ebp + 12]
    push ebx
    
    mov eax, [ebx + edi * 4]
    push eax
    push format
    call printf
    add esp, 8
    pop ebx

    inc edi
    cmp edi, esi
    jl loop4

    pop esi
    pop edi
    pop edx

    ; TODO a: Implement array printing function:
    ; print_v(unsigned int len, unsigned int *v);

    leave
    ret


main:
    push ebp
    mov ebp, esp


    ; Print arr1 using print_arr.

    mov eax, arr1
    mov ebx, len1
    push eax
    push ebx
    call print_v
    add esp, 8

    ; Compute elems in dest using elem_adj.

    push dest
    push arr1
    push k
    push len1
    call elem_adj
    add esp, 16

    ; Print dest using print_arr.

    mov eax, dest
    mov ebx, k
    push eax
    push ebx
    call print_v
    add esp, 8

    ; Compute elem_inplace in arr1.

    ; Print arr1 using print_arr.

    ; Return 0.
    xor eax, eax
    leave
    ret
