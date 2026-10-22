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
    mov eax, 4026531840
    mov ebx, [num]
    and ebx, eax
    cmp ebx, eax
    jne do_not_print
    PRINTF32 `%d\n\x0`, 1
do_not_print:

    ; TODO b: determine if num is divisible by 4
    ;xor edx, edx
    ;mov eax, [num]
    ;mov ecx, 4
    ;div ecx
    ;cmp edx, 0
    mov eax, [num]
    and eax, 3
    jnz not_divisible
    PRINTF32 `divizibil cu 4\n\x0`
not_divisible:

    ; TODO c: determine if num has an even number of bits set
    ;mov ecx, 0
    mov eax, [num]
    popcnt ebx, eax


not_par:

;Lagain:
    ;cmp eax, 0
    ;je done
    ;mov ebx, eax
    ;shr ebx, 1
    ;and eax, 1
    ;mov eax, ebx
    ;jz Lagain
    ;add ecx, 1
    ;jmp Lagain

;done:

    and ebx, 1
    jnz odd
    PRINTF32 `par\n\x0`
odd:
    ; Return 0.
    xor eax, eax
    leave
    ret
