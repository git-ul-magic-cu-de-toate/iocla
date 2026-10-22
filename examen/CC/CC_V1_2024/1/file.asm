%include "printf32.asm"

section .data
    n1 dd 65535
    n2 dd 67174399
    arr1 dd 1, 22, 313, 5125, 818, 0
    len1 equ $-arr1
    arr2 dw 1, 0, -3, 5, 91, -7
    len2 equ $-arr2

section .text
    extern printf
global main

main:
    push ebp
    mov ebp, esp


    ; TODO a: Determine whether a 4 bytes number has the first 16 bits
    ; equal to the second 16 bits negated
    mov eax, 131070  ; should print equal
    mov edx, eax
    shr edx, 16
    and eax, 0xffff
    not edx
    and edx, 0xffff
    cmp eax, edx
    je equal

    PRINTF32 `not equal\n\x0`
    jmp end_ex1_cc

equal:
    PRINTF32 `equal\n\x0`

    ; TODO b: Determine the sum of the last digit for the numbers saved
    ; in arr1
    xor esi, esi
    xor ecx, ecx

loop1:
    cmp esi, 6
    jge end_loop1

    xor edx, edx 
    ; mov eax, arr1
    ; mov edi, esi
    ; imul edi, 4
    ; add eax, edi
    mov eax, [arr1 + 4 * esi]
    mov ebx, 10
    div ebx
    add ecx, edx

    inc esi
    jmp loop1

end_loop1:
    PRINTF32 `%d\n\x0`, ecx

    ; TODO c: Print all pairs from arr2 that have the first number on a 3k
    ; index, the second number on a 3k + 2 index and the second number
    ; equal to the first number negated - 1
    xor esi, esi

loop2:
    mov edx, esi
    add edx, 2
    cmp edx, 6
    jge end_loop2

    mov ax, word [arr2 + 2 * esi]
    mov bx, word [arr2 + 2 * (esi + 2)]

    mov cx, ax
    not ax
    dec ax

    xor ax, bx
    cmp ax, 0

    jne next_iteration2

    PRINTF32 `%hd %hd\n\x0`, ecx, ebx

next_iteration2:
    mov esi, edx 
    inc esi
    jmp loop2

end_loop2:

end_ex1_cc:
    ; Return 0.
    xor eax, eax
    leave
    ret
