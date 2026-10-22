extern printf
extern scanf

section .data
    fmt_int db "%d", 0
    fmt_int_newline db "%d", 10, 0
    fmt_int_space db "%d ", 0
    newline db 10, 0
    N dd 5
    ;length dd 0

section .bss
    res resb 100
    res1 resb 100
    length resb 1

section .text
global main

; TODO a: Implement `void pow4(int *n)` which modifies the
; integer pointed by n by calculating 4 to the power of n
; In other words, *n = 4 ^ (*n)

pow4:
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov eax, [ebp + 8]
    mov ebx, [eax]
    mov ecx, 0x1

loopin:
    imul ecx, 4
    dec ebx
    cmp ebx, 0
    jne loopin

    mov [eax], ecx

    pop edi
    pop esi
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
    push edi
    push esi
    
    mov edx, [ebp + 8]
    mov eax, [ebp + 12]

    push edx
    push fmt_int
    call scanf
    add esp, 8

    mov edi, [ebp + 8]
    mov esi, [edi]
    mov ecx, [ebp + 12]
    
while:
    mov ebx, ecx
    push dword ecx
    push fmt_int
    call scanf
    add esp, 8

    dec esi
    mov ecx, ebx
    add ecx, 4
    cmp esi, 0
    ja while

    push esi
    push edi
    push ebx

    leave
    ret

; TODO c: Implement `void print_array(int n, int *v)` that prints
; the elements of the array stored in v of n integers.

print_array:
    push ebp
    mov ebp, esp

    mov edi, [ebp + 8]
    mov ebx, [ebp + 12]
loop1:
    mov ecx, [ebx]
    push ecx
    push fmt_int_space
    call printf
    add esp, 8
    add ebx, 4
    dec edi
    cmp edi, 0
    jne loop1

    leave
    ret

; TODO d: Implement `void map_array(int n, int *v, void (*f)(int *))`
; which updates every element of the array by applying the function
; sent as the third parameter

map_array:
    push ebp
    mov ebp, esp

    mov edi, [ebp + 8]
    mov ebx, [ebp + 12]
    

loop2:
    mov ecx, [ebp + 16]
    push ebx
    push ebx
    call ecx
    add esp, 4
    pop ebx
    add ebx, 4
    dec edi
    cmp edi, 0
    jne loop2

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Call `pow4` with the value N, stored in .data
    ; NOTE: You must print the modified value of N afterwards
a:
    mov eax, N
    push eax
    call pow4
    add esp, 4

    mov eax, [N]
    push eax
    push fmt_int_newline
    call printf
    add esp, 8
    

    ; TODO b: Call `read_array` with the address of a variable saved
    ; on stack as the length of the array and the array saved in a
    ; section of your choice
    ; NOTE: You must print the array afterwards by using the function
    ; implemented at TODO c
b:
    mov ebx, res1
    mov eax, length
    push ebx
    push eax
    call read_array
    add esp, 8

c:
    mov eax, [length]
    mov ebx, res1
    push ebx
    push eax
    call print_array
    add esp, 8

    ; TODO d: Call `map_array` with the length and array read at the
    ; first task and `pow4` as the third argument
    ; NOTE: You must print the array afterwards by using the function
    ; implemented at TODO c

d:
    mov eax, pow4
    mov ebx, [length]
    mov ecx, res1
    push eax
    push ecx
    push ebx
    call map_array
    add esp, 12

    mov eax, [length]
    mov ebx, res1
    push ebx
    push eax
    call print_array
    add esp, 8

    ; Return 0.
    xor eax, eax
    leave
    ret
