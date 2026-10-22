%include "printf32.asm"

section .data
    a1 dd 0x40000000
    b1 dd 0x40000001
    a2 dd 0x0
    b2 dd 0x10
    n dw 0xA01
    arr dw 0x3448, 0x3434, 0x6B63, 0x6E69, 0x2067, 0x6874, 0x2065, 0x6F77, 0x6C72, 0x2E64
    len equ $-arr


section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp


    ; TODO a: Determine whether the sum of 2 ints results in overflow

    mov eax, [a1]
    mov ebx, [b1]

    add eax, ebx
    jo overflow1

    PRINTF32 `You can eat more bacalhau\n\x0`
    jmp end1

overflow1:
    PRINTF32 `Go on a diet, Pisi\n\x0`

end1:


    mov eax, [a2]
    mov ebx, [b2]

    add eax, ebx
    jo overflow2

    PRINTF32 `You can eat more bacalhau\n\x0`
    jmp end2

overflow2:
    PRINTF32 `Go on a diet, Pisi\n\x0`

end2:


    ; TODO b: Determine the position of the first set bit starting from the
    ; left for the little endian representation of a 16 bit number

    mov ecx, 16
    mov ebx, 32768

for:    
    mov eax, [n]
    and eax, ebx
    sub ecx, 1
    shr ebx, 1
    cmp eax, 0
    je for

    PRINTF32 `%d\n\x0`, ecx
    
    ; TODO c: For every short saved in arr, replace the first byte starting
    ; from the right for the little endian representation of the number that
    ; is equal to 0x34 with 0x61.

    mov ecx, 0

for3:
    xor eax, eax
    mov ax, word [arr + 2 * ecx]

    cmp al, 0x34
    jne nuinlocuim

    mov al, 0x61
    mov word [arr + 2 * ecx], ax

nuinlocuim:
    PRINTF32 `%c%c\x0`, byte [arr + 2 * ecx], byte [arr + 2 * ecx + 1]
    add ecx, 1
    cmp ecx, 20
    jne for3




    ; Return 0.
    xor eax, eax
    leave
    ret
