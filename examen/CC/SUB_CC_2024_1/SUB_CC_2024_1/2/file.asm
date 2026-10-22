extern printf
extern atoi

section .data
    fmt_int db "%d", 0
    fmt_int_newline db "%d", 10, 0
    fmt_int_space db "%d ", 0
    newline db 10, 0

section .text
global main

; TODO c: Implement `int to_int(int n, int *v)` that concatenates
; all n numbers from v into a new one
; It is guaranteed that the result will fit into an int value

to_int:
    push ebp
    mov ebp, esp

    push ebx
    push edi
    push esi

    mov ebx, [ebp + 8]
    mov ecx, [ebp + 12]

    mov eax, 0
    dec ebx

end2:
    mov edx, [ecx + ebx * 4]
    
    imul eax, 10
    add eax, edx

    dec ebx
    cmp ebx, 0
    jge end2


    pop esi
    pop edi
    pop ebx

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
    mov ebx, [ebp + 12]
    ;mov eax, [ebx + 4] ;- vectorul
    ;mov edx, [ebx + 8]
    dec ecx
    xor edi, edi
    mov edi, 1
    sub esp, 4
    mov dword [esp], 0
loop1:
    push ebx
    push edi
    push ecx
    mov esi, [ebx + edi * 4]
    push esi
    call atoi
    add esp, 4
    pop ecx
    pop edi
    pop ebx
    cmp eax, 0
    jbe cond1

    inc dword [esp]
    jmp cond1

cond1:
    inc edi
    cmp edi, ecx
    jbe loop1

    mov eax, [esp]
    push eax
    push fmt_int_newline
    call printf
    add esp, 8


    ; TODO b: Convert all command-line arguments that represent a
    ; number to int and save them in an array placed on stack
    ; NOTE: You must print the array afterwards; you may use the
    ; value computed at task a in doing so
    ; HINT: man atoi (https://man7.org/linux/man-pages/man3/atoi.3.html)

    mov eax, [esp]
    mov ecx, [ebp + 8]
    mov ebx, [ebp + 12]
    ;mov eax, [ebx + 4] ;- vectorul
    ;mov edx, [ebx + 8]
    dec ecx
    xor edi, edi
    mov edi, 1
loop2:
    push eax
    push ebx
    push edi
    push ecx
    mov esi, [ebx + edi * 4]
    push esi
    call atoi
    add esp, 4
    pop ecx
    pop edi
    pop ebx
    cmp eax, 0
    jbe comp2

lol2:
    mov edx, eax
    pop eax
    sub esp, 4
    mov [esp], edx
    jmp cond2

comp2:
    pop eax

cond2:
    inc edi
    cmp edi, ecx
    jbe loop2

    dec eax

end:
    mov ebx, [esp + eax * 4]
    push eax
    push ebx
    push fmt_int_space
    call printf
    add esp, 8
    pop eax
    dec eax
    cmp eax, 0
    jge end

    
    ; TODO c: Call `to_int` with the value computed at task a and
    ; the array got at task b
c:
    mov eax, [ebp - 4]
    push esp
    push eax
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
