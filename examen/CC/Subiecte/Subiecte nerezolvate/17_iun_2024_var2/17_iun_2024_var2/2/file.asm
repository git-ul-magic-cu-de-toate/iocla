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



    ; TODO b: Convert all command-line arguments that represent a
    ; number to int and save them in an array placed on stack
    ; NOTE: You must print the array afterwards; you may use the
    ; value computed at task a in doing so
    ; HINT: man atoi (https://man7.org/linux/man-pages/man3/atoi.3.html)



    ; TODO c: Call `to_int` with the value computed at task a and
    ; the array got at task b


    ; Return 0.
    xor eax, eax
    leave
    ret
