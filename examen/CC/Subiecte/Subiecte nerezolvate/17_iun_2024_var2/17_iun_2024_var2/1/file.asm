%include "printf32.asm"

section .data
    a1 dd 0x40000000
    b1 dd 0x40000001
    a2 dd 0x0
    b2 dd 0x10
    n dw 0xA01
    arr dw 0x3448, 0x3434, 0x6B63, 0x6E69, 0x2067, 0x6874, 0x2065, 0x6F77, 0x6C72, 0x2E64
    len equ $-arr


section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp


    ; TODO a: Determine whether the sum of 2 ints results in overflow



    ; TODO b: Determine the position of the first set bit starting from the
    ; left for the little endian representation of a 16 bit number



    ; TODO c: For every short saved in arr, replace the first byte starting
    ; from the right for the little endian representation of the number that
    ; is equal to 0x34 with 0x61.


    ; Return 0.
    xor eax, eax
    leave
    ret
