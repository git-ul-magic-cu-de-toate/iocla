extern printf
extern scanf

section .data
    fmt_int db "%d", 0
    fmt_int_newline db "%d", 10, 0
    fmt_int_hexa db "%x", 0
    fmt_int_hexa_space db "0x%x ", 0
    fmt_ip db "%d.%d.%d.%d", 10, 0
    newline db 10, 0

section .text
global main

; TODO a: Implement `void read_array(int *n, int *v)` which reads
; an integer, stores it at the address pointed by n, and then proceeds
; to read an array of n integers in hex format

read_array:
    push ebp
    mov ebp, esp

    leave
    ret


; TODO b: Implement `void print_ip(int n)` that prints the ip format
; of n

print_ip:
    push ebp
    mov ebp, esp

    leave
    ret

; TODO c: Implement `int fibo(int n)` that recursively determines
; the nth Fibonacci sequence element

fibo:
    push ebp
    mov ebp, esp

    leave
    ret

main:
    push ebp
    mov ebp, esp


    ; TODO a: Call `read_array` with the address of a variable saved
    ; wherever as the length of the array and the array saved in a
    ; section of your choice
    ; NOTE: You must print the array afterwards in hex format



    ; TODO b: Call `print_ip` with the first element stored
    ; in the array read at task a



    ; TODO c: Call `fibo` with a value for n of your choice
    ; NOTE: You must print the result afterwards


    ; Return 0.
    xor eax, eax
    leave
    ret
