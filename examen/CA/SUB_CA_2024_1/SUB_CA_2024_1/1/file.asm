%include "printf32.asm"



section .data
    n dd 0x10
    arr dd 118, 2, 88, 16, 17, 13, 8, 15, 338, 78
    len equ $-arr

; TODO b: Define res, an array of integers

section .bss
    res resb 10000


section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    ;pusha
    ; TODO a: Determine, without using div, whether a number is odd or even

    mov eax, 1
    and eax, [n]
    cmp eax, 0
    jne impar

par:
    PRINTF32 `even\n\x0`
    jmp main2

impar:
    PRINTF32 `odd\n\x0`

  
main2:  
    ; TODO b: Save in res and print all the numbers from arr with an even
    ; index and with the last digit 8

    xor eax, eax
    mov ecx, 0x0
    mov ebx, 0x0
    

loopin:
    ;push edx
    push ebx
    ;dec ecx
    mov eax, [arr + 4 * ecx]
    mov ebx, 0xa
    xor edx, edx
    div ebx
    ;PRINTF32 `%d\n\x0`, edx
    pop ebx
    cmp edx, 0x8
    jne continuing

    mov eax, res
    push ebx
    imul ebx, 4
    add eax, ebx
    mov ebx, [arr + 4 * ecx]
    mov [eax], ebx
    pop ebx
    inc ebx

continuing:
    inc ecx
    cmp ecx, 0xa
    jb loopin

    ;dec ebx
    mov eax, res
print:
    PRINTF32 `%d \x0`, [eax]
    add eax, 4
    dec ebx
    cmp ebx, 0
    jne print
    PRINTF32 `\n\x0`

main3:
    ; TODO c: Print all the pairs of numbers on consecutive positions from arr
    ; with the same last bit

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx

    
    mov ebx, 0x0
    ;inc ebx

loopin2:
    ;mov eax, arr + ebx * 4
    mov ecx, [arr + ebx * 4]
    mov edx, [arr + ebx * 4 + 4]
    mov esi, 0x1
    and esi, ecx
    mov edi, 0x1
    and edi, edx
    cmp esi, edi
    jne test
    mov ecx, [arr + ebx * 4]
    mov edx, [arr + ebx * 4 + 4]
    PRINTF32 `%d %d\n\x0`, ecx, edx

test:
    inc ebx
    cmp ebx, 0x9
    jb loopin2

    ; Return 0.
    xor eax, eax
    leave
    ret
