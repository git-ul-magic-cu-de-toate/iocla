
%include "../utils/printf32.asm"

%define ARRAY_SIZE 3

section .data
    word_array dw 1896, 9773, -892
    print_format db "The number of odd values: ", 0
    print_form db "The number of even values: ", 0

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    mov ecx, ARRAY_SIZE ; Use ecx as loop counter.
    xor ebx, ebx ; odd
    xor edx, edx ; even
    
iteration:
    mov ax, word [word_array + 2 * (ecx - 1)]
    and ax, 1
    jz even

odd:
    inc ebx
    jmp finish

even:
    inc edx

finish:

    loop iteration; Decrement ecx, if not zero, add another element.

    PRINTF32 `%s\x0`, print_format
    PRINTF32 `%u\n\x0`, ebx

    PRINTF32 `%s\x0`, print_form
    PRINTF32 `%u\n\x0`, edx

    leave
    ret 