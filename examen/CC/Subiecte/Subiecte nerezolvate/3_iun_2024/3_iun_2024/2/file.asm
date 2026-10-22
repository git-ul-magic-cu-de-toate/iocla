extern printf
extern scanf

section .data
    fmt_int db "%d", 0
    fmt_int_newline db "%d", 10, 0
    fmt_int_space db "%d ", 0
    newline db 10, 0
    N dd 5

section .text
global main

; TODO a: Implement `void pow4(int *n)` which modifies the
; integer pointed by n by calculating 4 to the power of n
; In other words, *n = 4 ^ (*n)

pow4:
    push ebp
    mov ebp, esp

    leave
    ret

; TODO b: Implement `void read_array(int *n, int *v)` which reads
; an integer, stores it at the address pointed by n, and then proceeds
; to read an array of n integers

read_array:
    push ebp
    mov ebp, esp

    leave
    ret

; TODO c: Implement `void print_array(int n, int *v)` that prints
; the elements of the array stored in v of n integers.

print_array:
    push ebp
    mov ebp, esp

    leave
    ret

; TODO d: Implement `void map_array(int n, int *v, void (*f)(int *))`
; which updates every element of the array by applying the function
; sent as the third parameter

map_array:
    push ebp
    mov ebp, esp

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Call `pow4` with the value N, stored in .data
    ; NOTE: You must print the modified value of N afterwards

    ; TODO b: Call `read_array` with the address of a variable saved
    ; on stack as the length of the array and the array saved in a
    ; section of your choice
    ; NOTE: You must print the array afterwards by using the function
    ; implemented at TODO c

    ; TODO d: Call `map_array` with the length and array read at the
    ; first task and `pow4` as the third argument
    ; NOTE: You must print the array afterwards by using the function
    ; implemented at TODO c

    ; Return 0.
    xor eax, eax
    leave
    ret
