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
    jo overflow

    PRINTF32 `no\n\x0`
    jmp end_cc_2

overflow:
    PRINTF32 `yes\n\x0`

    ; TODO b: Determine the position of the first set bit starting from the
    ; left for the little endian representation of a 16 bit number
    xor eax, eax
    mov ax, [n]
    xor ecx, ecx
    xor edx, edx
cnt:
    cmp ecx, 16
    jge end_cnt

    mov ebx, 1
    and ebx, eax
    cmp eax, 1
    jne next_iter_cnt
    mov edx, ecx

next_iter_cnt:
    shr eax, 1
    inc ecx
    jmp cnt

end_cnt:
    PRINTF32 `%d\n\x0`, edx

    ; TODO c: For every short saved in arr, replace the first byte starting
    ; from the right for the little endian representation of the number that
    ; is equal to 0x34 with 0x61.
    xor ecx, ecx
replace:
    cmp ecx, 10
    jge end_replace

    mov al, byte [arr + 2 * ecx]
    cmp al, 0x34
    jne next_iter_rep
    mov byte [arr + 2 * ecx], 0x61

next_iter_rep:
    inc ecx
    jmp replace

end_replace:
    PRINTF32 `%s\n\x0`, arr

end_cc_2:
    ; Return 0.
    xor eax, eax
    leave
    ret
