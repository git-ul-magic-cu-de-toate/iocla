%include "printf32.asm"

section .data
    a dd 0x10
    b dd 0x25
    arr dd 10, 4, 2, 3, 5, 16
    len equ $-arr

; TODO b: Define res, an array of integers

section .bss
    res resb 50

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp


    ; TODO a: Determine, without using div, the number of even numb in [a, b]

    mov eax, [a]
    mov ebx, [b]
    sub ebx, eax
    shr ebx, 1
    mov edi, 1
    and eax, edi
    cmp eax, 0
    jne test2
    inc ebx
test2:
    mov ecx, [b]
    and ecx, edi
    cmp ecx, 0
    jne end
    inc ebx
end:
    PRINTF32 `%d\n\x0`, ebx


    ; TODO b: Save in res and print all the numbers from arr with an even
    ; index and with the last digit 8


    mov eax, 0
    mov ecx, 0
loop1:
    mov ebx, [arr + eax * 4]
    cmp ebx, dword [a]
    jl final

    cmp ebx, dword [b]
    ja final

    mov edi, 1
    and edi, ebx
    cmp edi, 1
    jne final

    mov [res + ecx * 4], ebx
    inc ecx

final:
    inc eax
    cmp eax, 0x6
    jne loop1

    mov edi, 0
loop3:
    PRINTF32 `%d \x0`, [res + edi * 4]
    inc edi
    cmp edi, ecx
    jl loop3

    PRINTF32 `\n\x0`

    ; TODO c: Print all the pairs of numbers on consecutive positions from arr
    ; with the last bit different

    mov eax, 0x0
loop4:
    mov ebx, [arr + eax * 4]
    mov ecx, [arr + eax * 4 + 4]
    mov esi, 1
    mov edi, 1
    and esi, ebx
    and edi, ecx
    cmp esi, edi
    je test3

    PRINTF32 `%d %d\n\x0`, ebx, ecx

test3:
    inc eax
    cmp eax, 0x5
    jb loop4

    ; Return 0.
    xor eax, eax
    leave
    ret
