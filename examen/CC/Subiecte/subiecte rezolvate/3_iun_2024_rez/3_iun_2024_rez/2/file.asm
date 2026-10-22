extern printf
extern scanf

section .data
    fmt_int db "%d", 0
    fmt_int_newline db "%d", 10, 0
    fmt_int_space db "%d ", 0
    newline db 10, 0
    N dd 5

section .bss
    v:    resd 10
    n resd 1

section .text
global main

; TODO a: Implement `void pow4(int *n)` which modifies the
; integer pointed by n by calculating 4 to the power of n
; In other words, *n = 4 ^ (*n)

pow4:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]      ; se ia adresa pointerului lui n
    mov ebx, [eax]          ; se ia valoarea de la pointerului lui n

    cmp ebx, 0      ; verificam daca n=0
    je ret_1

    mov edx, 1

    xor ecx, ecx

for1:
    imul esi, edx, 4    ; facem inmultirea edx * 4 = esi
    mov edx, esi
    
    add ecx, 1      ; trecem la urmatoarea inmultire atata timp cat nu se
    cmp ecx, ebx    ; trece de valoarea lui n
    jl for1

    mov [eax], edx      ; trecem la adresa pointerului ce se returneaza, valoarea ceruta
    jmp end1

ret_1:
    mov dword [eax], 1

end1:
    leave
    ret

; TODO b: Implement `void read_array(int *n, int *v)` which reads
; an integer, stores it at the address pointed by n, and then proceeds
; to read an array of n integers

read_array:
    push ebp
    mov ebp, esp

    mov esi, [ebp + 8]          ; adresa lui n
    mov edi, [ebp + 12]         ; adresa lui v

    pusha
    push esi
    push fmt_int
    call scanf
    add esp, 8
    popa

    xor ecx, ecx
    mov ebx, [esi]      ; valoarea lui n

for_read:
    lea edx, [edi + 4 * ecx]

    pusha
    push edx
    push fmt_int
    call scanf
    add esp, 8
    popa

    add ecx, 1      ; trecem la urmatoarea inmultire atata timp cat nu se
    cmp ecx, ebx    ; trece de valoarea lui n
    jl for_read

    xor ecx, ecx

    leave
    ret

; TODO c: Implement `void print_array(int n, int *v)` that prints
; the elements of the array stored in v of n integers.

print_array:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]      ; valoarea lui n
    mov edi, [ebp + 12]     ; adresa lui v

   ; pusha
   ; push ebx
   ; push fmt_int_newline
   ; call printf
   ; add esp, 8
   ; popa

    xor ecx, ecx

for_print:
    mov edx, [edi + 4 * ecx]    ; valoarea primului element

    pusha
    push edx
    push fmt_int_space
    call printf
    add esp, 8
    popa

    add ecx, 1
    cmp ecx, ebx
    jl for_print

    pusha
    push newline
    call printf
    add esp, 4
    popa


    leave
    ret

; TODO d: Implement `void map_array(int n, int *v, void (*f)(int *))`
; which updates every element of the array by applying the function
; sent as the third parameter

map_array:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]      ; valoarea lui n
    mov edi, [ebp + 12]     ; adresa lui v
    mov eax, [ebp + 16]     ; adresa functiei

    xor ecx, ecx

for_map:
    imul esi, ecx, 4
    add esi, edi

    push ebx
    push edi
    push eax
    push ecx
    
    push esi
    call eax
    add esp, 4

    pop ecx
    pop eax
    pop edi
    pop ebx

    inc ecx
    cmp ecx, ebx
    jl for_map


    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Call `pow4` with the value N, stored in .data
    ; NOTE: You must print the modified value of N afterwards

    push N          ; adresa pointerului care merge la n
    call pow4
    add esp, 4

    push dword [N]  ; adresa valorii lui n
    push fmt_int_newline
    call printf
    add esp, 8


    ; TODO b: Call `read_array` with the address of a variable saved
    ; on stack as the length of the array and the array saved in a
    ; section of your choice
    ; NOTE: You must print the array afterwards by using the function
    ; implemented at TODO c

    push v
    push n
    call read_array
    add esp, 8

    push v
    push dword [n]
    call print_array
    add esp, 8

    ; TODO d: Call `map_array` with the length and array read at the
    ; first task and `pow4` as the third argument
    ; NOTE: You must print the array afterwards by using the function
    ; implemented at TODO c

    push pow4
    push v
    push dword [n]
    call map_array
    add esp, 12

    push v
    push dword [n]
    call print_array
    add esp, 8
    

    ; Return 0.
    xor eax, eax
    leave
    ret
