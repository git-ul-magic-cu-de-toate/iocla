extern printf
extern scanf

section .data
    fmt_int db "%d", 0
    fmt_int_newline db "%d", 10, 0
    fmt_int_hexa db "%x", 0
    fmt_int_hexa_space db "0x%x ", 0
    fmt_ip db "%d.%d.%d.%d", 10, 0
    newline db 10, 0

section .bss
    res resb 400
    length resb 4

section .text
global main

; TODO a: Implement `void read_array(int *n, int *v)` which reads
; an integer, stores it at the address pointed by n, and then proceeds
; to read an array of n integers in hex format

read_array:
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov eax, [ebp + 8]
    push eax
    push fmt_int
    call scanf
    add esp, 8

    mov eax, [ebp + 8]
    mov ecx, [eax]
    mov ebx, 0
loop2:
    push ecx
    mov edx, [ebp + 12]
    push ebx
    imul ebx, 4
    add edx, ebx
    push edx
    push fmt_int_hexa
    call scanf
    add esp, 8
    pop ebx
    pop ecx
    inc ebx
    cmp ebx, ecx
    jb loop2

    pop edi
    pop esi
    pop ebx

    leave
    ret


print_array:
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    mov esi, [ebp + 8]
    mov ebx, [ebp + 12]
    mov edi, 0
loop3:
    mov eax, [ebx + edi * 4]
    push eax
    push fmt_int_hexa_space
    call printf
    add esp, 8

    inc edi
    cmp edi, esi
    jl loop3


    pop edi
    pop esi
    pop ebx

    leave
    ret

; TODO b: Implement `void print_ip(int n)` that prints the ip format
; of n

print_ip:
    push ebp
    mov ebp, esp

    pusha

    

    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    mov dl, byte al
    shr eax, 8
    mov cl, byte al
    shr eax, 8
    mov bl, byte al
    shr eax, 8

    push edx
    push ecx
    push ebx
    push eax
    push fmt_ip
    call printf
    add esp, 20


    popa

    leave
    ret

; TODO c: Implement `int fibo(int n)` that recursively determines
; the nth Fibonacci sequence element

fibo:
    push ebp
    mov ebp, esp

    push ebx
    push edi
    push esi

    mov edx, [ebp + 8]
    sub edx, 2
    mov eax, 0
    mov ebx, 1
fiboRec:
    add eax, ebx
    push eax
    push ebx
    pop eax
    pop ebx
    dec edx
    cmp edx, 0
    jnl fiboRec

    mov eax, ebx

    pop esi
    pop edi
    pop ebx

    leave
    ret

main:
    push ebp
    mov ebp, esp


    ; TODO a: Call `read_array` with the address of a variable saved
    ; wherever as the length of the array and the array saved in a
    ; section of your choice
    ; NOTE: You must print the array afterwards in hex format

    mov eax, length
    mov ebx, res
    push ebx
    push eax
    call read_array
    add esp, 8

    mov eax, [length]
    mov ebx, res
    push ebx
    push eax
    call print_array
    add esp, 8

    ; TODO b: Call `print_ip` with the first element stored
    ; in the array read at task a

    xor eax, eax
    mov eax, [res]
    push eax
    call print_ip
    add esp, 4


    ; TODO c: Call `fibo` with a value for n of your choice
    ; NOTE: You must print the result afterwards

    mov eax, 0x6
    push eax
    call fibo
    add esp, 4

    push eax
    push fmt_int_newline
    call printf
    add esp, 8
    ; Return 0.
    xor eax, eax
    leave
    ret
