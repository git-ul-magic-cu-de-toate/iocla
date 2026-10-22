%include "printf32.asm"

section .data
    n dd 0x10
    arr dd 118, 2, 88, 16, 17, 13, 8, 15, 338, 78
    len equ $-arr

; TODO b: Define res, an array of integers

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp


    ; TODO a: Determine, without using div, whether a number is odd or even



    ; TODO b: Save in res and print all the numbers from arr with an even
    ; index and with the last digit 8



    ; TODO c: Print all the pairs of numbers on consecutive positions from arr
    ; with the same last bit


    ; Return 0.
    xor eax, eax
    leave
    ret
