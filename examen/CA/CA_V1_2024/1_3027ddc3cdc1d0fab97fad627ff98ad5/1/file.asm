%include "printf32.asm"

section .data
    n dd 0x10
    arr dd 118, 2, 88, 16, 17, 13, 8, 15, 338, 78
    len equ $-arr
    odd: dd "odd", 0
    even: dd "even", 0

; TODO b: Define res, an array of integers
section .bss
    res: resd 10

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp


    ; TODO a: Determine, without using div, whether a number is odd or even
    mov eax, dword [n]
    and eax, 1
    cmp eax, 0
    je even_label
    PRINTF32 `%s\n\x0`, odd
    jmp end
even_label:
    PRINTF32 `%s\n\x0`, even

    ; TODO b: Save in res and print all the numbers from arr with an even
    ; index and with the last digit 8
    xor eax, eax
    mov ecx, 0

loop1:
    cmp eax, 10
    jge end_loop1

    mov esi, eax
    and esi, 1
    cmp esi, 0
    jne next_iteration1

    mov esi, eax
    mov eax, [arr + 4 * eax]
    xor edx, edx
    mov ebx, 10
    div ebx

    mov eax, esi
    cmp edx, 8
    jne next_iteration1

    mov esi, [arr + 4 * eax]
    mov [res + 4 * ecx], esi

    inc ecx

next_iteration1:

    inc eax
    jmp loop1

end_loop1:

    xor eax, eax
loop2:
    cmp eax, ecx
    jge end_loop2

    PRINTF32 `%d\n\x0`, [res + 4 * eax]

    inc eax
    jmp loop2

end_loop2:
    ; TODO c: Print all the pairs of numbers on consecutive positions from arr
    ; with the same last bit
    PRINTF32 `\n\x0`

    xor ecx, ecx
loop3:
    cmp ecx, 9
    jge end

    mov esi, [arr + 4 * ecx]
    mov edi, [arr + 4 * (ecx + 1)]

    and esi, 1
    and edi, 1

    cmp esi, edi
    jne next_iteration3

    PRINTF32 `%d %d\n\x0`, [arr + 4 * ecx], [arr + 4 * (ecx + 1)]

next_iteration3:
    inc ecx
    jmp loop3

end:
    ; Return 0.
    xor eax, eax
    leave
    ret
