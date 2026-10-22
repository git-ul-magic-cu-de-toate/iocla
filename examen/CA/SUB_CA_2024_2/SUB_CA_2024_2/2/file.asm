extern printf
extern scanf

section .data
    fmt_int db "%d", 0
    fmt_int_newline db "%d", 10, 0
    fmt_int_space db "%d ", 0
    newline db 10, 0
    N dd 23132

section .bss
    res resb 10000
    length resb 4
    res1 resb 10000
    length1 resb 4

section .text
global main

; TODO a: Implement PALINDROME `void pow4(int *n)` which modifies the
; integer pointed by n by calculating 4 to the power of n
; In other words, *n = 4 ^ (*n)

palindrome:
    push ebp
    mov ebp, esp

    push ebx
    push edi
    push esi

    mov eax, [ebp + 8]
    mov edi, eax ;copie
    mov ecx, 0xa
    mov esi, 0 ;nr rasturnat
    mov ebx, 0 ;puteri ale lui 10
loop1:
    cmp eax, 10
    jnb cont
    add esi, eax
    jmp cont2
cont:  
    xor edx, edx
    div ecx
    add esi, edx
    imul esi, 0xa
    jmp loop1
    
cont2:
    cmp esi, edi
    jne notad

    mov eax, 1
    jmp end1

notad:
    mov eax, 0

end1:
    pop esi
    pop edi
    pop ebx

    leave
    ret

; TODO b: Implement `void read_array(int *n, int *v)` which reads
; an integer, stores it at the address pointed by n, and then proceeds
; to read an array of n integers

read_array:
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov ebx, [ebp + 8]
    

    push ebx
    push fmt_int
    call scanf
    add esp, 8

    mov ebx, [ebp + 8]
    mov eax, [ebx] ; length
    mov edi, 0
    mov esi, [ebp + 12]

loop2:
    push eax
    mov ecx, dword [ebp + 12]
    push edi
    imul edi, 4
    add ecx, edi
    push ecx
    push fmt_int
    call scanf
    add esp, 8
    pop edi
    pop eax
    inc edi
    cmp edi, eax
    jb loop2

    pop edi
    pop esi
    pop ebx

    leave
    ret

; TODO c: Implement `void print_array(int n, int *v)` that prints
; the elements of the array stored in v of n integers.

print_array:
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]

loop3:
    mov ecx, [ebx]
    push eax
    push ebx
    push ecx
    push fmt_int_space
    call printf
    add esp, 8
    pop ebx
    pop eax
    add ebx, 4
    dec eax
    cmp eax, 0
    ja loop3

    pop edi
    pop esi
    pop ebx

    leave
    ret

; TODO d: Implement `void map_array(int n, int *v, void (*f)(int *))`
; which updates every element of the array by applying the function
; sent as the third parameter

filter_array:
    push ebp
    mov ebp, esp

    push ebx
    push edi
    push esi

    mov edi, [ebp + 8]
    mov esi, 0 ;indice vect initial
    mov ecx, 0 ;indice vect final

loop4:
    mov ebx, [ebp + 12]
    push esi
    imul esi, 4
    add ebx, esi
    pop esi
    mov eax, [ebx]
    push ecx
    mov ecx, [ebp + 16]
    push eax
    call ecx
    add esp, 4
    pop ecx
    cmp eax, 1
    jne notvalid

    mov eax, res1 ; + ecx * 4
    push ecx
    imul ecx, 4
    add eax, ecx
    pop ecx
    mov ebx, [ebp + 12]
    push esi
    imul esi, 4
    add ebx, esi
    pop esi
    mov edx, [ebx]
    mov [eax], edx
    inc ecx

notvalid:
    inc esi
    cmp esi, edi
    jne loop4

    mov eax, length1
    mov [eax], ecx
    pop esi
    pop edi
    pop ebx
    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Call `pow4` with the value N, stored in .data
    ; NOTE: You must print the modified value of N afterwards

    push dword [N]
    call palindrome
    add esp, 4

    push eax
    push fmt_int_newline
    call printf
    add esp, 8

    ; TODO b: Call `read_array` with the address of a variable saved
    ; on stack as the length of the array and the array saved in a
    ; section of your choice
    ; NOTE: You must print the array afterwards by using the function
    ; implemented at TODO c

    mov eax, res
    mov ebx, length
    push eax
    push ebx
    call read_array
    add esp, 8

    mov eax, res
    mov ebx, [length]
    push eax
    push ebx
    call print_array
    add esp, 8

    ; TODO d: Call `map_array` with the length and array read at the
    ; first task and `pow4` as the third argument
    ; NOTE: You must print the array afterwards by using the function
    ; implemented at TODO c

    mov eax, [length]
    mov ebx, res
    mov ecx, palindrome
    push ecx
    push ebx
    push eax
    call filter_array
    add esp, 12

    mov eax, res1
    mov ebx, [length1]
    push eax
    push ebx
    call print_array
    add esp, 8

    ; Return 0.
    xor eax, eax
    leave
    ret
