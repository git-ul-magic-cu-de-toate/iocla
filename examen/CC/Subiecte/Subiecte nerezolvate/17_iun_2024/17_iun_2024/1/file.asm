%include "printf32.asm"

section .data
    n1 dd 65535
    n2 dd 67174399
    arr1 dd 1, 22, 313, 5125, 818, 0
    len1 equ $-arr1
    arr2 dw 1, 0, -3, 5, 91, -7
    len2 equ $-arr2

section .text
global main

main:
    push ebp
    mov ebp, esp


    ; TODO a: Determine whether a 4 bytes number has the first 16 bits
    ; equal to the second 16 bits negated



    ; TODO b: Determine the sum of the last digit for the numbers saved
    ; in arr1



    ; TODO c: Print all pairs from arr2 that have the first number on a 3k
    ; index, the second number on a 3k + 2 index and the second number
    ; equal to the first number negated - 1


    ; Return 0.
    xor eax, eax
    leave
    ret
