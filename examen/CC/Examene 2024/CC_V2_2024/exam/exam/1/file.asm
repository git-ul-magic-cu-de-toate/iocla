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
    jno not_overflow
    PRINTF32 `Go on a diet, Pisi\n\x0`
    jmp overflow_cont
not_overflow:
    PRINTF32 `You can eat more bacalhau\n\x0`

overflow_cont:

    mov eax, [a2]
    mov ebx, [b2]
    add eax, ebx
    jno not_overflow1
    PRINTF32 `Go on a diet, Pisi\n\x0`
    jmp overflow_cont1
not_overflow1:
    PRINTF32 `You can eat more bacalhau\n\x0`

overflow_cont1:


    ; TODO b: Determine the position of the first set bit starting from the
    ; left for the little endian representation of a 16 bit number
    xor eax, eax
    mov ax, [n]
    xor edx, edx
    mov ecx, 1

last_byte:
    test ax, ax
    jz last_byte_cont
    test ax, 1
    jnz last_not_set
    mov edx, ecx
last_not_set:
    inc ecx
    shr ax, 1
    jmp last_byte

last_byte_cont:

    PRINTF32 `%d\n\x0`, edx


    ; TODO c: For every short saved in arr, replace the first byte starting
    ; from the right for the little endian representation of the number that
    ; is equal to 0x34 with 0x61.

    mov esi, arr
    mov ecx, len
vect_loop:
    mov eax, [esi]
    cmp al, 0x34
    jnz vect_loop_cont
    mov al, 0x61
vect_loop_cont:
    movzx ebx, ah
    movzx eax, al
    PRINTF32 `%c%c\x0`, eax, ebx
    add esi, 2
    loop vect_loop

    PRINTF32 `\n\x0`


    ; Return 0.
    xor eax, eax
    leave
    ret
