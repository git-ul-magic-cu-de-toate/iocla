%include "printf32.asm"
extern printf

section .data

limit dd  120
len equ   10

section .bss
    ; TODO a: Reserve space for an array of `len` integers. The array name is `int_arr`
    int_arr:    resd len

section .text
global main
extern printf

main:
    push ebp
    mov ebp, esp

    ;TODO a: Generate first `len` elements of `int_arr` defined as follows:
    ; int_arr[i] = 17 * i + 3

    xor ecx, ecx

for:
    mov eax, ecx
    mov ebx, 17
    mul ebx

    add eax, 3

    mov dword [int_arr + 4 * ecx], eax

    add ecx, 1
    cmp ecx, len
    jl for

    xor ecx, ecx

for1:
    PRINTF32 `%d \x0`, [int_arr + 4 * ecx]
    add ecx, 1
    cmp ecx, len
    jl for1
    
    PRINTF32 `\n\x0`

    ; TODO b: Count the number of elements strictly smaller than number pointed by `limit`

    xor ecx, ecx
    xor eax, eax
    mov edx, [limit]

for2:
    mov ebx, [int_arr + 4 * ecx]
    
    cmp ebx, edx
    jg nonumber

    add eax, 1

nonumber:
    add ecx, 1
    cmp ecx, len
    jl for2

    PRINTF32 `TOD0 b result is %d\n\x0`, eax

    ; TODO c: Find and print the smallest number strictly greater than number pointed by `limit`

    xor ecx, ecx
    mov edx, [limit]

for3:
    mov ebx, [int_arr + 4 * ecx]
    
    cmp ebx, edx
    jl nextno

    PRINTF32 `TOD0 c result is %d\n\x0`, ebx
    jmp end3

nextno:
    add ecx, 1
    cmp ecx, len
    jl for3

end3:

    ; Return 0.
    xor eax, eax
    leave
    ret
