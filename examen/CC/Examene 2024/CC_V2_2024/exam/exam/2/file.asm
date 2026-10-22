extern printf
extern atoi

section .data
    fmt_int db "%d", 0
    fmt_int_newline db "%d", 10, 0
    fmt_int_space db "%d ", 0
    newline db 10, 0
    fmt_str_newline db "%s", 10, 0

section .text
global main

; TODO c: Implement `int to_int(int n, int *v)` that concatenates
; all n numbers from v into a new one
; It is guaranteed that the result will fit into an int value


main:
    push ebp
    mov ebp, esp


    ; TODO a: Traverse all command-line arguments and compute
    ; how many of them represent a natural number
    ; The result value must be placed on stack
    ; NOTE: You must print the result afterwards
    ; HINT: man atoi (https://man7.org/linux/man-pages/man3/atoi.3.html)
    mov ecx, [ebp + 8]
    mov esi, [ebp + 12]
    add esi, 4
    dec ecx
    xor edi, edi

get_args:
    push ecx
    push dword [esi]
    call atoi
    add esp, 4
    pop ecx
    cmp eax, 1
    jl get_args_cont
    inc edi
get_args_cont:
    add esi, 4
    loop get_args

    push edi
    push fmt_int_newline
    call printf
    add esp, 8


    ; TODO b: Convert all command-line arguments that represent a
    ; number to int and save them in an array placed on stack
    ; NOTE: You must print the array afterwards; you may use the
    ; value computed at task a in doing so
    ; HINT: man atoi (https://man7.org/linux/man-pages/man3/atoi.3.html)
    mov ebx, edi
    lea ecx, [edi * 4]
    sub esp, ecx
    mov edi, esp

    mov ecx, [ebp + 8]
    mov esi, [ebp + 12]
    add esi, 4
    dec ecx
    xor edx, edx


make_vector:
    push edx
    push ecx
    push dword [esi]
    call atoi
    add esp, 4
    pop ecx
    pop edx
    cmp eax, 1
    jl make_vector_cont
    mov [edi + edx * 4], eax
    inc edx
make_vector_cont:
    add esi, 4
    loop make_vector

    xor ecx, ecx
print_vector:
    cmp ecx, ebx
    jz print_vector_exit
    push ecx
    push dword [edi + ecx * 4]
    push fmt_int_space
    call printf
    add esp, 8
    pop ecx
    inc ecx
    jmp print_vector

print_vector_exit:
    push newline
    call printf
    add esp, 4
    ; TODO c: Call `to_int` with the value computed at task a and
    ; the array got at task b
    push edi
    push ebx
    call to_int
    add esp, 8

    push eax
    push fmt_int_newline
    call printf
    add esp, 8


    ; Return 0.
    xor eax, eax
    leave
    ret

to_int:
    push ebp
    mov ebp, esp
    push esi
    push edi
    push ecx
    push edx
    push ebx

    mov esi, [ebp + 12]
    mov ecx, [ebp + 8]
    xor edi, edi
    mov ebx, dword 10

to_int_loop:
    mov eax, edi
    mul ebx
    mov edi, eax
    add edi, [esi]
    add esi, 4
    loop to_int_loop

    mov eax, edi

to_int_exit:
    
    pop ebx
    pop edx
    pop ecx
    pop edi
    pop esi
    leave
    ret
