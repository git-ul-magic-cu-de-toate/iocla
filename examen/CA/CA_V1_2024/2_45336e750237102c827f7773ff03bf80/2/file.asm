extern printf
extern scanf

section .data
    fmt_int db "%d", 0
    fmt_int_newline db "%d", 10, 0
    fmt_int_space db "%d ", 0
    newline db 10, 0
    N dd 5
    v: times 100 dd 0

section .text
global main

; TODO a: Implement `void pow4(int *n)` which modifies the
; integer pointed by n by calculating 4 to the power of n
; In other words, *n = 4 ^ (*n)

pow4:
    push ebp
    mov ebp, esp

    mov edx, [ebp + 8]  ; N
    mov ecx, [edx]

    mov eax, 1
loop4:
    imul eax, 4
    loop loop4
    
    mov [edx], eax

    leave
    ret

; TODO b: Implement `void read_array(int *n, int *v)` which reads
; an integer, stores it at the address pointed by n, and then proceeds
; to read an array of n integers

read_array:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8] ; adresa lui n
    mov ebx, [ebp + 12] ; v

    pusha
    push eax
    push fmt_int
    call scanf
    add esp, 8
    popa

    mov eax, [eax]

    ; push eax
    ; push fmt_int_space
    ; call printf
    ; add esp, 8

    xor edx, edx
loop5:
    cmp edx, eax
    jge end_loop5

    lea esi, [ebx + 4 * edx]
    pusha
    push esi
    push fmt_int
    call scanf
    add esp, 8
    popa

    inc edx
    jmp loop5

end_loop5:
    leave
    ret

; TODO c: Implement `void print_array(int n, int *v)` that prints
; the elements of the array stored in v of n integers.

print_array:
    push ebp
    mov ebp, esp

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

; TODO d: Implement `void map_array(int n, int *v, void (*f)(int *))`
; which updates every element of the array by applying the function
; sent as the third parameter

map_array:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    mov ecx, [ebp + 16]

xor edx, edx
loop7:
    cmp edx, eax
    jge end_loop7

    lea esi, [ebx + 4 * edx]
    pusha
    push esi
    call ecx
    add esp, 4
    popa

    inc edx
    jmp loop7

end_loop7:
    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Call `pow4` with the value N, stored in .data
    ; NOTE: You must print the modified value of N afterwards
    lea eax, [N]
    push eax
    call pow4
    add esp, 4

    mov eax, [N]

    push eax
    push fmt_int
    call printf
    add esp, 8

    push newline
    call printf
    add esp, 4
    ; TODO b: Call `read_array` with the address of a variable saved
    ; on stack as the length of the array and the array saved in a
    ; section of your choice
    ; NOTE: You must print the array afterwards by using the function
    ; implemented at TODO c
    lea ebx, [v]
    sub esp, 4
    lea eax, [ebp - 4]

    push ebx
    push eax
    call read_array
    add esp, 8

    push ebx
    push eax
    call print_array
    add esp, 8

    ; TODO d: Call `map_array` with the length and array read at the
    ; first task and `pow4` as the third argument
    ; NOTE: You must print the array afterwards by using the function
    ; implemented at TODO c
    push pow4
    push ebx
    push eax
    call map_array
    add esp, 8

    push ebx
    push eax
    call print_array
    add esp, 8

    ; Return 0.
    xor eax, eax
    leave
    ret
