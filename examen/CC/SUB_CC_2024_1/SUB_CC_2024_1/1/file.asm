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
    add eax, [b1]
    jo diet

no_diet:
    PRINTF32 `you can eat more balcahau\n\x0`
    jmp cont01

diet:
    PRINTF32 `Go on a diet, Pisi\n\x0`

cont01:
    mov eax, [a2]
    add eax, [b2]
    jo diet1

no_diet1:
    PRINTF32 `you can eat more balcahau\n\x0`
    jmp cont0

diet1:
    PRINTF32 `Go on a diet, Pisi\n\x0`


cont0:
    ; TODO b: Determine the position of the first set bit starting from the
    ; left for the little endian representation of a 16 bit number

    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    mov ax, word [n]
    xor ebx, ebx
    mov ebx, 1
    shl ebx, 15
    mov edx, 15
loop1:
    xor ecx, ecx
    mov ecx, ebx
    and cx, ax
    cmp cx, 0
    je not_found

found:
    jmp cont1

not_found:
    dec edx
    shr ebx, 1
    cmp edx, 0
    jae loop1

cont1:
    PRINTF32 `%d\n\x0`, edx
    ; TODO c: For every short saved in arr, replace the first byte starting
    ; from the right for the little endian representation of the number that
    ; is equal to 0x34 with 0x61.

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx

    mov ebx, 0

loop2:
    xor eax, eax
    mov ax, word [arr + ebx * 2]
    cmp al, 0x34
    jne cond2

    mov al, 0x61
    mov [arr + ebx * 2], ax
    xor ecx, ecx
    

cond2:
    mov cl, al
    PRINTF32 `%c\x0`, ecx

    mov cl, ah
    PRINTF32 `%c\x0`, ecx
    inc ebx
    cmp ebx, 10
    jb loop2

    ; Return 0.
    xor eax, eax
    leave
    ret
