%include "printf32.asm"
extern printf

section .data

limit dd  120
len equ   10

section .bss
    ; TODO a: Reserve space for an array of `len` integers. The array name is `int_arr`

section .text
global main

main:
    push ebp
    mov ebp, esp

    ;TODO a: Generate first `len` elements of `int_arr` defined as follows:
    ; int_arr[i] = 17 * i + 3

    ; TODO b: Count the number of elements strictly smaller than number pointed by `limit`

    ; TODO c: Find and print the smallest number strictly greater than number pointed by `limit`

    ; Return 0.
    xor eax, eax
    leave
    ret
