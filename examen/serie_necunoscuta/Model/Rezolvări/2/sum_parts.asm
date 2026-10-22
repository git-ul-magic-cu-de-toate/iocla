extern scanf
extern printf


section .data
    uint_format    db "%zu", 0
    uint_format_newline    db "%zu", 10, 0
    pos1_str    db "Introduceti prima pozitie: ", 0
    pos2_str   db "Introduceti a doua pozitie: ", 0
    sum_str db "Suma este: %zu", 10, 0
    sum_interval_str db "Suma de la pozitia %zu la pozitia %zu este %zu", 10, 0
    arr     dd 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400

section .bss
    poz1 resd 1
    poz2 resd 1


section .text
global main


sum:
    push ebp
    mov ebp, esp

    ; TODO b: Implement sum() to compute sum for array.

    mov esi, [ebp + 8] ; arr
    mov ebx, [ebp + 12] ; n
    xor eax, eax ; pentru suma
    xor ecx, ecx ; contor pentru loop

loop_a:
    cmp ecx, ebx
    je end_a

    mov edi, [esi + 4*ecx]
    add eax, edi

    inc ecx
    jmp loop_a

end_a:

    leave
    ret


sum_interval:
    push ebp
    mov ebp, esp

    ; TODO b: Implement sum_interval() to compute sum for array between two positions.

    mov edx, [ebp + 8] ; arr
    mov edi, [ebp + 12] ; pos1
    mov esi, [ebp + 16] ; pos2

    xor eax, eax ; pentru suma
    xor ecx, ecx ; contor pentru loop

loop_b:
    cmp ecx, edi
    jl exit

    cmp ecx, esi
    jge end_b

    mov ebx, [edx + 4*ecx]
    add eax, ebx

exit:
    inc ecx
    jmp loop_b

end_b:

    leave
    ret


main:
    push ebp
    mov ebp, esp


    push dword 14
    push arr
    call sum
    add esp, 8

    push eax
    push sum_str
    call printf
    add esp, 8


    ; TODO b: Call sum_interval() and print result.

    xor eax, eax

    push dword 9
    push dword 5
    push arr
    call sum_interval
    add esp, 12

    push eax
    push dword 9
    push dword 5
    push sum_interval_str
    call printf
    add esp, 16


    ; TODO c: Use scanf() to read positions from standard input.

    xor esi, esi ; pos1
    xor edi, edi ; pos2
    xor eax, eax

    push pos1_str
    call printf
    add esp, 4

    push poz1
    push uint_format
    call scanf
    add esp, 8

    mov esi, [poz1]

    push pos2_str
    call printf
    add esp, 4

    push poz2
    push uint_format
    call scanf
    add esp, 8

    mov edi, [poz2]

    push edi
    push esi
    push arr
    call sum_interval
    add esp, 12

    push eax
    push esi
    push edi
    push sum_interval_str
    call printf
    add esp, 16


    ; Return 0.
    xor eax, eax
    leave
    ret
