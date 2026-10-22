%include "printf32.asm"
extern printf

section .data
M dd -20
N dd 90

arr dd -30, -20, -10, 40, 50, 60, 70, 80, 90, 100
len equ 10
fmt_int dd "%d ", 0
fmt_newline dd 10, 0

section .bss

; TODO b: Declarati variabla de tip `double word` cu numele `in_len`
in_len resd 1

; TODO c: Declarati vectorul de intregi (`double word`) `res` cu maximum `len` elemente
res times len resd 4

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Determinați cum este plasat numarul arr[0] relativ la intervalul [M, N], unde M < N. Afisati:
    ; -1, daca numarul arr[0] se afla la stanga intervalului (arr[0] < M)
    ; 0, daca numarul arr[0] se gaseste in intervalul [M, N] (M <= arr[0] <= N)
    ; 1, daca numarul arr[0] se gaseste la dreapta intervalului (arr[0] > N)
    mov eax, [arr] ; arr[0]
    mov esi, [M]
    mov edi, [N]

    xor ebx, ebx

    cmp eax, esi
    jl mai_mic

    cmp eax, edi
    jg mai_mare

    push ebx
    push fmt_int
    call printf
    add esp, 8

    push fmt_newline
    call printf
    add esp, 4

    jmp end_a

mai_mare:
    mov ebx, 1

    push ebx
    push fmt_int
    call printf
    add esp, 8

    push fmt_newline
    call printf
    add esp, 4

    jmp end_a

mai_mic:
    mov ebx, -1

    push ebx
    push fmt_int
    call printf
    add esp, 8

    push fmt_newline
    call printf
    add esp, 4

    jmp end_a

end_a:

    ; TODO b: Calculati si afisati numarul elementelor din vectorul `arr` care se gasesc
    ; in intervalul [M, N]. Retineti aceasta valoare in variabila `in_len` din sectiunea `.bss`.

    xor eax, eax
    xor ebx, ebx
    xor esi, esi
    xor edi, edi

    mov ebx, len
    mov esi, [M]
    mov edi, [N]
    xor ecx, ecx ; contor pentru loop
    xor eax, eax ; contor pt nr gasite

loop_b:
    cmp ecx, ebx
    je end_b

    mov edx, [arr + ecx*4]

    cmp edx, esi
    jl prep_b

    cmp edx, edi
    jg prep_b

    inc eax

prep_b:
    inc ecx
    jmp loop_b

end_b:
    mov [in_len], eax

    push eax
    push fmt_int
    call printf
    add esp, 8

    push fmt_newline
    call printf
    add esp, 4

    ; TODO c: Completati vectorul `res` de dimensiune maxima `len` cu elementele din
    ; vectorul `arr` care se gasesc in intervalul [M, N].
    ; Declarati vectorul `res` in sectiunea `bss`.

    xor eax, eax
    xor ebx, ebx
    xor esi, esi
    xor edi, edi
    xor edx, edx

    mov edi, [M]
    mov esi, [N]
    xor ecx, ecx; contor pentru arr
    xor edx, edx; contor pentru res
    mov ebx, len

loop_c:
    cmp ecx, ebx
    je end_c

    mov eax, [arr + ecx*4]

    cmp eax, edi
    jl skip

    cmp eax, esi
    jg skip

    mov [res + edx*4], eax
    inc edx

skip:   
    inc ecx
    jmp loop_c

end_c:

    ; TODO d: Afisati vectorul `res` de dimensiune `in_len` cu elementele
    ; pe aceeasi linie separate de un spatiu
    xor ecx, ecx
    xor eax, eax

loop_d:
    cmp ecx, edx
    je end_d

    xor eax, eax
    mov eax, [res + 4*ecx]

    push ecx
    push edx

    push eax
    push fmt_int
    call printf
    add esp, 8

    pop edx
    pop ecx

    inc ecx
    jmp loop_d

end_d:
    push fmt_newline
    call printf
    add esp, 4

    ; Return 0.
    xor eax, eax
    leave
    ret
