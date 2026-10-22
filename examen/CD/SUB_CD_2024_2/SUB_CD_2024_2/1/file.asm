%include "printf32.asm"
extern printf

section .data

limit dd  120
len equ   10

section .bss
    ; TODO a: Reserve space for an array of `len` integers. The array name is `int_arr`
    int_arr resb 40

section .text
global main

main:
    push ebp
    mov ebp, esp

    ;TODO a: Generate first `len` elements of `int_arr` defined as follows:
    ; int_arr[i] = 17 * i + 3
    mov ecx, len
    ;dec ecx
loop1:
    mov eax, ecx
    imul eax, 17
    add eax, 3
    mov edx, int_arr
    push ecx
    imul ecx, 4
    add edx, ecx
    pop ecx
    mov [edx], eax

    loop loop1
    mov dword [int_arr], 0x3
    mov ecx, len
    ;dec ecx
    mov ebx, 0
loop2:
    mov edx, [int_arr + ebx*4]
    PRINTF32 `%d \x0`, edx
    inc ebx
    loop loop2

    ; TODO b: Count the number of elements strictly smaller than number pointed by `limit`

    PRINTF32 `\n\x0`
    mov ecx, len
    dec ecx
    mov ebx, 0
loop3:
    mov edx, [int_arr + ecx*4]
    cmp edx, [limit]
    jge cont1

    inc ebx

cont1:
    dec ecx
    cmp ecx, 0
    jge loop3

    PRINTF32 `TOD0 b result is %d\n\x0`, ebx

    ; TODO c: Find and print the smallest number strictly greater than number pointed by `limit`

    mov eax, 0xFFFFF

    mov ecx, len
    dec ecx
    mov ebx, 0
loop4:
    mov edx, [int_arr + ebx*4]
    cmp edx, [limit]
    jle cont2

    cmp edx, eax
    jge cont2

    mov eax, edx

cont2:
    inc ebx
    dec ecx
    cmp ecx, 0
    jge loop4

    PRINTF32 `TOD0 c result is %d\n\x0`, eax

    ; Return 0.
    xor eax, eax
    leave
    ret
