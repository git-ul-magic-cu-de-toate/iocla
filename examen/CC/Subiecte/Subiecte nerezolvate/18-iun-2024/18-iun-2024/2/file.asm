extern puts
extern printf

section .rodata
    format db "%u ", 0
    puts_format db "", 0

section .data
    arr1 dd 10, 20, 30, 40, 50, 60, 70, 80, 11, 22, 33, 44, 55, 66, 77, 88, 99
    ; b) c) Test with k = 1, 7, 0, 17, 18
    len1 equ 17
    k equ 18

section .bss
    dest resd 100

section .text
global main

elem_adj:
    push ebp
    mov ebp, esp

    ; TODO b: Implement adjacent computing function:
    ; elem_adj(unsigned int len, int k, unsigned int *v, unsigned int *w)

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

    ; TODO a: Implement array printing function:
    ; print_v(unsigned int len, unsigned int *v);

    leave
    ret


main:
    push ebp
    mov ebp, esp


    ; Print arr1 using print_arr.

    ; Compute elems in dest using elem_adj.

    ; Print dest using print_arr.

    ; Compute elem_inplace in arr1.

    ; Print arr1 using print_arr.

    ; Return 0.
    xor eax, eax
    leave
    ret
