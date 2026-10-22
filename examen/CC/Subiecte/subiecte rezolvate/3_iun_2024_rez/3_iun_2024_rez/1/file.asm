%include "printf32.asm"

section .data
    n dd 0x10
    arr dd 118, 2, 88, 16, 17, 13, 8, 15, 338, 78
    len equ $-arr
    res dd 0, 0, 0, 0, 0, 0

; TODO b: Define res, an array of integers

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp


    ; TODO a: Determine, without using div, whether a number is odd or even

    mov eax, [n]

    mov ebx, 1

    and eax, ebx
    cmp eax, 0
    je par

    PRINTF32 `odd\n\x0`
    jmp end1
    
par:
    PRINTF32 `even\n\x0`

end1:


    ; TODO b: Save in res and print all the numbers from arr with an even
    ; index and with the last digit 8

    xor ecx, ecx
    xor ebx, ebx

for:
    mov eax, [arr + 4 * ecx]

    push ecx
    mov ecx, 10
    xor edx, edx
    idiv ecx
    pop ecx

    cmp edx, 8
    je copy

    cmp edx, 8
    jne redofor


copy:
    push eax
    mov eax, [arr + 4 * ecx]
    mov dword [res + 4 * ebx], eax
    add ebx, 1


redofor:
    add ecx, 2

    cmp ecx, 9
    jl for


    xor ecx, ecx

for1:
    PRINTF32 `%d \x0`, [res + 4 * ecx]
    add ecx, 1

    cmp ecx, ebx
    jl for1

    PRINTF32 `\n\x0`


    ; TODO c: Print all the pairs of numbers on consecutive positions from arr
    ; with the same last bit

    xor ecx, ecx

for2:
    mov eax, [arr + 4 * ecx]
    mov ebx, [arr + 4 * ecx + 4]

    and eax, 1
    and ebx, 1

    cmp eax, 0
    je bit_nul

bit_nenul:
    cmp ebx, 1
    je ambele

    jmp nu_ambele


bit_nul:
    cmp ebx, 0
    je ambele

    jmp nu_ambele


ambele:
    PRINTF32 `%d %d\n\x0`, [arr + 4 * ecx], [arr + 4 * ecx + 4]

nu_ambele:
    add ecx, 1
    cmp ecx, 9
    jl for2


    ; Return 0.
    xor eax, eax
    leave
    ret
