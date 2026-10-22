%include "printf32.asm"

section .data
    n1 dd 65535
    n2 dd 67174399
    arr1 dd 1, 22, 313, 5125, 818, 0
    len1 equ $-arr1
    arr2 dw 1, 0, -3, 5, 91, -7
    len2 equ $-arr2


section .text
global main
extern printf

main:
    push ebp
    mov ebp, esp


    ; TODO a: Determine whether a 4 bytes number has the first 16 bits
    ; equal to the second 16 bits negated
    mov eax, [n1]

    xor edx, edx
    mov dx, ax

    shr eax, 16
    xor ecx, ecx
    mov cx, ax
    not cx

    cmp ecx, edx
    jne not_re

    PRINTF32 `I am Xen\n\x0`
    jmp b

not_re:
    PRINTF32 `I am not Xen\n\x0`

b:
    xor eax, eax
    mov eax, [n2]

    xor edx, edx
    mov dx, ax

    shr eax, 16
    xor ecx, ecx
    mov cx, ax
    not cx
    cmp ecx, edx
    jne not_re1

    PRINTF32 `I am Xen\n\x0`
    jmp b1

not_re1:
    PRINTF32 `I am not Xen\n\x0`

b1:
    ; TODO b: Determine the sum of the last digit for the numbers saved
    ; in arr1

    xor eax, eax
    xor ecx, ecx
    xor edx, edx
    xor ebx, ebx
    mov esi, 0
    mov ecx, 5
    mov ebx, 0
loop1:
    mov eax, [arr1 + ebx * 4]
    xor edx, edx
    mov edi, 10
    div edi

    add esi, edx

    inc ebx
    cmp ebx, ecx
    jbe loop1


    PRINTF32 `%d\n\x0`, esi
    ; TODO c: Print all pairs from arr2 that have the first number on a 3k
    ; index, the second number on a 3k + 2 index and the second number
    ; equal to the first number negated - 1

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor esi, esi
    xor edi, edi

    mov ecx, 5
    mov ebx, 0

loop2:
    xor edx, edx
    mov eax, ebx
    mov edi, 0x3
    div edi
    cmp edx, 0
    jne cont1

    mov edi, ebx
    add edi, 2
    cmp edi, ecx
    jg end1

    xor edx, edx
    xor eax, eax
    mov ax, word [arr2 + ebx * 2]
    mov dx, word [arr2 + edi * 2]
    not dx
    dec dx
    cmp dx, ax
    jne cont1
    mov dx, word [arr2 + ebx * 2]
    mov ax, word [arr2 + edi * 2]
    PRINTF32 `%hi %hi\n\x0`, edx, eax

cont1:
    inc ebx
    cmp ebx, ecx
    jle loop2

end1:
    ; Return 0.
    xor eax, eax
    leave
    ret
