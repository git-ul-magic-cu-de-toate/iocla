extern printf
extern puts


section .rodata
    perimeter_msg     db "perimter is %zu", 10, 0
    area_msg     db "area is %zu", 10, 0
    perimeter_array_msg db "perimeter array is: ", 0
    area_array_msg db "area array is: ", 0
    simple_fmt   db "%zu ", 0
    empty_str   db "", 0
    first_array dd 10, 20, 30, 40, 50 ; vector latimi
    second_array dd 20, 30, 40, 50, 60 ; vector lungimi
    len equ 5
    fmt_int dd "%d ", 0
    fmt_newline dd 10, 0


section .bss
    perimeter_array resd 5
    area_array resd 5


section .text
global main


perimeter:
    push ebp
    mov ebp, esp

    ; TODO a: Implement perimeter(unsigned int first, unsigned int second) function.

    xor ecx, ecx
    xor ebx, ebx

    mov ecx, [ebp + 8] ; first
    mov ebx, [ebp + 12] ; second
    xor eax, eax

    add eax, ecx
    add eax, ecx
    add eax, ebx
    add eax, ebx

    leave
    ret


area:
    push ebp
    mov ebp, esp

    ; TODO b: Implement perimeter(unsigned int first, unsigned int second) function.
    xor eax, eax
    xor ebx, ebx

    mov eax, [ebp + 8] ; first
    mov ebx, [ebp + 12] ; second

    mul ebx

    leave
    ret


print_array:
    push ebp
    mov ebp, esp

    push dword [ebp+8]
    call printf
    add esp, 4

    mov ebx, [ebp+12]
    xor ecx, ecx
loop:
    push ebx
    push ecx
    push dword [ebx + ecx * 4]
    push simple_fmt
    call printf
    add esp, 8

    pop ecx
    pop ebx
    inc ecx
    cmp ecx, [ebp+16]
    jne loop

    push empty_str
    call puts
    add esp, 4

    leave
    ret


main:
    push ebp
    mov ebp, esp


    ; TODO a: Call perimeter() function and print result.
    mov edi, [first_array]
    mov esi, [second_array]

    push esi
    push edi
    call perimeter
    add esp, 8

    push eax
    push perimeter_msg
    call printf
    add esp, 8


    ; TODO b: Call area() function and print result.

    xor edi, edi
    xor esi, esi

    mov edi, [first_array]
    mov esi, [second_array]

    push esi
    push edi
    call area
    add esp, 8

    push eax
    push area_msg
    call printf
    add esp, 8


    ; TODO c: Fill perimiter_array and area_array by calling perimeter()
    ; and area() functions on first_array and second_array.
    ; Print perimeter_array and area_array using print_array() function.

    xor esi, esi
    xor edi, edi
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx

loop_c:
    cmp ecx, len
    je prep_print_c_1

    mov eax, [first_array + 4*ecx] ; latime[i]
    mov ebx, [second_array + 4*ecx] ; lungime[i]

    xor edi, edi ; pentru perimteru

    add edi, eax
    add edi, eax
    add edi, ebx
    add edi, ebx

    mov [perimeter_array + 4*ecx], edi

    mul ebx

    mov [area_array + 4*ecx], eax

    inc ecx
    jmp loop_c

prep_print_c_1:
    xor ecx, ecx
    xor esi, esi

    push ecx

    push perimeter_array_msg
    call printf
    add esp, 4

    pop ecx

print_c_1:
    cmp ecx, len
    je prep_print_c_2

    mov esi, [perimeter_array + 4*ecx]

    push ecx

    push esi
    push fmt_int
    call printf
    add esp, 8

    pop ecx
    inc ecx
    jmp print_c_1

prep_print_c_2:
    xor ecx, ecx
    xor esi, esi

    push ecx

    push fmt_newline
    call printf
    add esp, 4

    push area_array_msg
    call printf
    add esp, 4

    pop ecx

print_c_2:
    cmp ecx, len
    je end_c

    mov esi, [area_array + 4*ecx]
    push ecx

    push esi
    push fmt_int
    call printf
    add esp, 8

    pop ecx
    inc ecx
    jmp print_c_2

end_c:
    push fmt_newline
    call printf
    add esp, 4

    ; Return 0.
    xor eax, eax
    leave
    ret
