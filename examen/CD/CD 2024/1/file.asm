%include "printf32.asm"
extern printf

section .data

    limit dd  120
    len equ   10
    fmt_int: db "%d ", 0
    newline: db 10, 0

section .bss
    ; TODO a: Reserve space for an array of `len` integers. The array name is `int_arr`
    int_arr: resd len

section .text
global main

main:
    push ebp
    mov ebp, esp

    ;TODO a: Generate first `len` elements of `int_arr` defined as follows:
    ; int_arr[i] = 17 * i + 3
    xor ecx, ecx
arr_loop:
    cmp ecx, len
    jge end_arr_loop

    mov edx, ecx
    imul edx, 17
    add edx, 3
    mov [int_arr + 4 * ecx], edx

    inc ecx
    jmp arr_loop

end_arr_loop:
    lea ebx, [int_arr]

    push ebx
    push len
    call print_array
    add esp, 8

    push newline
    call printf
    add esp, 4

    ; TODO b: Count the number of elements strictly smaller than number pointed by `limit`
    xor ecx, ecx
    xor edx, edx
cnt_loop:
    cmp ecx, len
    jge end_cnt_loop

    mov eax, [int_arr + 4 * ecx]
    cmp eax, [limit]
    jge next_iteration_cnt
    inc edx
    
next_iteration_cnt:
    inc ecx
    jmp cnt_loop

end_cnt_loop:
    push edx
    push fmt_int
    call printf
    add esp, 8

    ; TODO c: Find and print the smallest number strictly greater than number pointed by `limit`
    xor ecx, ecx
    mov edx, 200
cnt_loop2:
    cmp ecx, len
    jge end_cnt_loop2

    mov eax, [int_arr + 4 * ecx]
    cmp eax, [limit]
    jle next_iteration_cnt2
    cmp eax, edx
    jge next_iteration_cnt2
    mov edx, eax
    
next_iteration_cnt2:
    inc ecx
    jmp cnt_loop2

end_cnt_loop2:
    push edx
    push fmt_int
    call printf
    add esp, 8

    ; Return 0.
    xor eax, eax
    leave
    ret

print_array:
    push ebp
    mov ebp, esp

    mov ecx, [ebp + 8]
    mov ebx, [ebp + 12]

    xor eax, eax
loop6:
    cmp eax, ecx
    jge end_loop6

    mov edx, [ebx + 4 * eax]

    pusha
    push edx
    push fmt_int
    call printf
    add esp, 8
    popa

    inc eax
    jmp loop6

end_loop6:

    leave
    ret

