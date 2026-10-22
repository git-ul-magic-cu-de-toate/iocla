include "../utils/printf32.asm"

%define ARRAY_SIZE 5

section .data
    word_array dw 1893, 9773, -892, 327, -223
    print_format db "The number of positive values: ", 0
    print_form db "The number of negative values: ", 0

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    mov ecx, ARRAY_SIZE     ; Use ecx as loop counter.
    xor ebx, ebx
    xor edx, edx
    
iteration:
    mov ax, word [word_array + 2 *(ecx - 1)]
    cmp ax, 0
    jg positive
    jmp negative

positive:
    inc ebx
    jmp finish

negative:
    inc edx

finish:
    loop iteration; Decrement ecx, if not zero, add another element.

    PRINTF32 `%s\x0`, print_format
    PRINTF32 `%u\n\x0`, ebx

    PRINTF32 `%s\x0`, print_form
    PRINTF32 `%u\n\x0`, edx

    leave
    ret 