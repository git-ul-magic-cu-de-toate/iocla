%include "printf32.asm"
extern printf
extern calloc
extern scanf

section .data
    arr dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    N dd 10
    P dd 400
    Q dd 850
    fmt_int db "%u ", 0
    fmt_int2 db "%u", 0
    fmt_newline db 10, 0

section .text
global main

;TODO a: Implementati functia `void print_array(unsigned int *a, int N)` pentru a afisa
;   elementele vectorului `a` de dimensiune `N` pe o singura linie separate de cate un spatiu.
;
;   Afisarea se va face folosind functia `int printf(const char *format, ...);` din biblioteca standard C.
;
;   ATENTIE: Functia `printf` poate modifica registerele EAX, ECX si EDX. Pentru simplitate puteti folosi
;   instructiunile `pusha`, `popa` pentru a salva respectiv restaura toate registrele modificate de un apel de biblioteca.

print_array:
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8] ; arr
    mov ebx, [ebp + 12] ; N
    xor ecx, ecx

loop_a:
    cmp ecx, ebx
    je end_a
    mov edx, [eax + 4*ecx]

    push eax
    push ecx
    
    push edx
    push fmt_int
    call printf
    add esp, 8

    pop ecx
    pop eax

    inc ecx
    jmp loop_a

end_a:
    popa
    leave
    ret

;TODO b: Implementati functia `int* alloc_array(int N)` care aloca memorie (dinamic) pentru `N` intregi. Memoria alocata va trebui zeroizata.
;   Pentru alocare de memorie puteti folosi functiile:
;   - `void *malloc(int size)`, care aloca `size` octeti. Memoria alocata nu este zeroizata.
;  SAU
;   - `void *calloc(size_t nmemb, size_t size)`, care aloca `nmemb` elemente fiecare de dimensiune `size`. Memoria alocata este zeroizata.
;
;   RECOMANDARE: folositi functia `calloc`
alloc_array:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8] ; N
    mov ebx, 4

    push ebx
    push eax
    call calloc
    add esp, 8

    leave
    ret

;TODO c: Implementati functia `void read_array(unsigned int *a, int N)` care citeste de la intrarea standard
;   un vector `a` de `N` numere intregi fara semn.
;
;   Citirea de la intrarea standard se va face folosind functia `int scanf(const char *format, ...);` din biblioteca standard C.
;   e.g pentru citirea unui intreg
;       unsigned int elem;
;       scanf("%u", &elem);

read_array:
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8] ; a
    mov ebx, [ebp + 12] ; N
    xor ecx, ecx

loop_c:
    cmp ecx, ebx
    je end_c

    push ecx
    push eax
    push ebx

    push eax
    push fmt_int2
    call scanf
    add esp, 8

    pop ebx
    pop eax
    pop ecx

    add eax, 4
    inc ecx
    jmp loop_c

end_c:
    popa
    leave
    ret

; TODO d: Implementati functia void update_interval(int *a, int N, int P, int Q)` care
;   va face urmatoarele operatii asupra sirului de elemente intregi fara semn `a` de dimensiune `N`"
;
;   a[i] = 2 * a[i], daca elementul a[i] se gaseste in intervalul [P, Q]
;   a[i] = a[i] / 2, daca elemente a[i] se gaseste in afara intervalului [P, Q]
;
; ATENTIE: este garantat ca P <= Q pentru toate apelurile functiei `update_interval`.

update_array:
    push ebp
    mov ebp, esp
    pusha

    xor eax, eax
    xor ebx, ebx
    xor esi, esi
    xor edi, edi

    mov eax, [esp + 8] ; a
    mov ebx, [esp + 12] ; N
    mov esi, [esp + 16] ; P
    mov edi, [esp + 20] ; Q

    xor ecx, ecx

loop_d:
    cmp ecx, ebx
    je end_d

    xor edx, edx
    mov edx, 2
    push ebx
    mov ebx, [eax + 4*ecx]

    cmp ebx, esi
    jl division
    cmp ebx, edi
    jg division

    push eax
    mov eax, ebx
    mul edx
    mov edx, eax
    pop eax
    mov [eax + 4*ecx], edx

    inc ecx
    pop ebx
    jmp loop_d

division:
    push eax
    mov eax, ebx
    div edx
    mov edx, eax
    pop eax
    mov [eax + 4*ecx], edx

    inc ecx
    pop ebx
    jmp loop_d

end_d:
    popa
    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Apelati functia `print_array(int *a, int N)` pentru a afisa vectorul `arr` de dimensiune `N` definit in sectiunea `.data`
    mov esi, [N]
    mov edi, arr

    push esi
    push edi
    call print_array
    add esp, 8

    push fmt_newline
    call printf
    add esp, 4


    ; TODO b: Alocati memorie pentru un vector de N intregi fara semn, apeland functia `alloc_array`
    ; si apoi afisati vectorul apeland functia `print_array`.

    mov esi, [N]

    push esi
    call alloc_array

    push esi
    push eax
    call print_array
    add esp, 8

    push eax

    push fmt_newline
    call printf
    add esp, 4

    pop eax

    ; TODO c: Cititi de la intrarea standard un vector de `N` intregi apeland functia `read_array`
    ; si apoi afisati vectorul folosind functia `print_array`.

    mov esi, [N]
    
    push esi
    push eax
    call read_array
    add esp, 8

    push esi
    push eax
    call print_array
    add esp, 8

    push eax

    push fmt_newline
    call printf
    add esp, 4

    pop eax

    ; TODO d: Transformati vectorul `a` de `N` elemente intregi fara semn citit la TODO c) apeland functia
    ; `update_array` si apoi afisati vectorul folosind functia `print_array`.
    ; Functia `update_array` va fi apelata astfel:
    ; `update_array(a, N, P, Q)` unde N, P si Q se gasesc in sectiunea `.data` iar vectorul `a` este cel citit la TODO c;

    xor edi, edi
    xor esi, esi
    xor edx, edx

    mov esi, [N]
    mov edi, [P]
    mov edx, [Q]

    push edx
    push edi
    push esi
    push eax
    call update_array
    add esp, 16

    push esi
    push eax
    call print_array
    add esp, 8

    ; Return 0.
    xor eax, eax
    leave
    ret
