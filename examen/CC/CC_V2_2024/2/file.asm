extern printf
extern atoi

section .data
    fmt_int db "%d", 0
    fmt_int_newline db "%d", 10, 0
    fmt_int_space db "%d ", 0
    newline db 10, 0
    fmt_string db "%s ", 0
    v: times 100 dd 0
    N dd 0

section .text
global main

; TODO c: Implement `int to_int(int n, int *v)` that concatenates
; all n numbers from v into a new one
; It is guaranteed that the result will fit into an int value

to_int:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    mov esi, [ebp + 12]

    xor eax, eax

    xor ecx, ecx 
concat:
    cmp ecx, ebx
    jge end_concat

    mov [N], ebx 
    sub dword [N], 1
    sub [N], ecx

    pusha
    push N
    call pow10
    add esp, 4
    popa

    mov edx, [esi + 4 * ecx]
    imul edx, [N]
    add eax, edx

    inc ecx
    jmp concat

end_concat:

    leave
    ret

pow10:
    push ebp
    mov ebp, esp

    mov edx, [ebp + 8]  ; N
    mov ecx, [edx]

    mov eax, 1

    cmp dword [edx], 0
    je end_pow10

loop4:
    imul eax, 10
    loop loop4
    
end_pow10:
    mov [edx], eax
    
    leave
    ret

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
    sub esp, 128

get_args:
    push ecx
    push dword [esi]
    call atoi
    add esp, 4
    pop ecx
    cmp eax, 1
    jl get_args_cont
    mov [esp + 4 * edi], eax
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
    push esp
    push edi 
    call print_arr
    add esp, 8

    ; TODO c: Call `to_int` with the value computed at task a and
    ; the array got at task b
    push esp
    push edi 
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

print_arr:
    push ebp
    mov ebp, esp

    ; TODO a: Implement array printing function:
    ; print_v(unsigned int len, unsigned int *v);
    mov ecx, [ebp + 8]
    mov ebx, [ebp + 12]

    xor eax, eax
loop6:
    cmp eax, ecx
    jge end_loop6

    mov edx, [ebx + 4 * eax]

    pusha
    push edx
    push fmt_int_space
    call printf
    add esp, 8
    popa

    inc eax
    jmp loop6

end_loop6:
    leave
    ret
