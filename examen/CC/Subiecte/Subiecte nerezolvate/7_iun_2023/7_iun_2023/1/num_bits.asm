%include "utils/printf32.asm"
extern printf

section .data
    num dd 0xff12438c
    num2 dd 8

section .text
global main
main:
    push ebp
    mov ebp, esp

    ; TODO a: determine if num has the most significant 4 bits set

    ; TODO b: determine if num is divisible by 4

    ; TODO c: determine if num has an even number of bits set

    ; Return 0.
    xor eax, eax
    leave
    ret
