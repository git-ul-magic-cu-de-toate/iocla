extern scanf
extern strrchr
extern strlen
extern printf
extern puts

section .data
    printf_fmt_int: db "%d", 10, 0
    anna:           db "Anna", 0
    scanf_fmt:      db "%10s", 0
    string:         times 11 db 0

section .text
global main

mystrrchr:
    push ebp
    mov ebp, esp

    ; TODO a

    leave
    ret

to_upper:
    push ebp
    mov ebp, esp

    ; TODO b
   
    leave
    ret

main:
    push ebp
    mov ebp, esp


    ; TODO a
    push 'n'
    push anna
    call mystrrchr
    add esp, 8
    push eax
    push printf_fmt_int
    call printf
    add esp, 8

    push 'x'
    push anna
    call mystrrchr
    add esp, 8
    push eax
    push printf_fmt_int
    call printf
    add esp, 8

    ; OUTPUT:
    ; 2
    ; -1

    ; TODO b
    push anna
    call to_upper
    add esp, 4
    push anna
    call puts
    add esp, 4

    ; OUTPUT:
    ; ANNA

    ; TODO c

    xor eax, eax
    leave
    ret
