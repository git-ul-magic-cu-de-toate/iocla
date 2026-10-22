extern printf
extern calloc
extern scanf

section .data
    arr dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    N dd 10
    P dd 400
    Q dd 850
    fmt_int db "%u ", 0
    fmt_aaaaaaaa db "%u", 0
    fmt_newline db 10, 0

section .text
global main

; int *arr = malloc(...); arr[0] = 0xfff1f2f3; arr[1] = 0x11 11 11 11; arr + 1
; 0x8080 ->0xff
; 0x8081 ->0xf1
; 0x8082 ->0xf2
; 0x8083 ->0xf3

; 0x8084 ->0x11

;TODO a: Implementati functia `void print_array(unsigned int *a, int N)` pentru a afisa
;   elementele vectorului `a` de dimensiune `N` pe o singura linie separate de cate un spatiu.
;
;   Afisarea se va face folosind functia `int printf(const char *format, ...);` din biblioteca standard C.
;
;   ATENTIE: Functia `printf` poate modifica registerele EAX, ECX si EDX. Pentru simplitate puteti folosi
;   instructiunile `pusha`, `popa` pentru a salva respectiv restaura toate registrele modificate de un apel de biblioteca.
; printf("%u ", a)
print_array:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]  ; a
    mov ebx, [ebp + 12] ; N

    xor ecx, ecx

parse_array:
    mov edx, [eax + 4 * ecx]

    pusha

    push edx
    push fmt_int
    call printf
    add esp, 8

    popa

    inc ecx
    cmp ecx, ebx
    jl parse_array


    pusha

    push fmt_newline
    call printf
    add esp, 4

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

    mov eax, [ebp + 8]

    push 4
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

    mov eax, [ebp + 8]  ; a
    mov ebx, [ebp + 12] ; N

    xor ecx, ecx

parse_array_2:

    ; scanf("%u", eax + 4 * ecx)
    lea edx, [eax + 4 * ecx] ; edx = &(*(eax + 4 * ecx))

    pusha
    push edx
    push fmt_aaaaaaaa
    call scanf
    add esp, 8
    popa

    inc ecx
    cmp ecx, ebx
    jl parse_array_2

    leave
    ret

; TODO d: Implementati functia void update_interval(int *a, int N, int P, int Q)` care
;   va face urmatoarele operatii asupra sirului de elemente intregi fara semn `a` de dimensiune `N`"
;
;   a[i] = 2 * a[i], daca elementul a[i] se gaseste in intervalul [P, Q]
;   a[i] = a[i] / 2, daca elemente a[i] se gaseste in afara intervalului [P, Q]
;
; ATENTIE: este garantat ca P <= Q pentru toate apelurile functiei `update_interval`.

update_interval:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]  ; a
    mov ebx, [ebp + 12] ; N

    xor ecx, ecx

parse_array_3:
    mov edx, [eax + 4 * ecx]

    cmp edx, [ebp + 16]
    jl out_of_interval

    cmp edx, [ebp + 20]
    jg out_of_interval

in_interval:
    mov esi, 2
    imul edx, esi

    mov [eax + 4 * ecx], edx
    jmp next_elem

out_of_interval:
    push eax
    push edx

    xor edx, edx
    xor eax, eax

    pop eax

    mov esi, 2
    idiv esi

    mov esi, eax
    pop eax
    mov [eax + 4 * ecx], esi

next_elem:
    inc ecx
    cmp ecx, ebx
    jl parse_array_3

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Apelati functia `print_array(int *a, int N)` pentru a afisa vectorul `arr` de dimensiune `N` definit in sectiunea `.data`
    push DWORD [N]
    push arr
    call print_array
    add esp, 8

    ; TODO b: Alocati memorie pentru un vector de N intregi fara semn, apeland functia `alloc_array`
    ; si apoi afisati vectorul apeland functia `print_array`.
    push DWORD [N]
    call alloc_array
    add esp, 4

    push DWORD [N]
    push eax
    call print_array
    add esp, 8

    ; TODO c: Cititi de la intrarea standard un vector de `N` intregi apeland functia `read_array`
    ; si apoi afisati vectorul folosind functia `print_array`.

    push DWORD [N]
    push eax
    call read_array
    add esp, 8

    push DWORD [N]
    push eax
    call print_array
    add esp, 8

    ; TODO d: Transformati vectorul `a` de `N` elemente intregi fara semn citit la TODO c) apeland functia
    ; `update_array` si apoi afisati vectorul folosind functia `print_array`.
    ; Functia `update_array` va fi apelata astfel:
    ; `update_array(a, N, P, Q)` unde N, P si Q se gasesc in sectiunea `.data` iar vectorul `a` este cel citit la TODO c;
    push DWORD [Q]
    push DWORD [P]
    push DWORD [N]
    push eax
    call update_interval
    add esp, 16

    push DWORD [N]
    push eax
    call print_array
    add esp, 8

    ; Return 0.
    xor eax, eax
    leave
    ret
