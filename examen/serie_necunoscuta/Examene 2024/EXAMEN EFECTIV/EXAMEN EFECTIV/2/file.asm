section .data
    int_fmt: db "%d", 10, 0
    newline_fmt: db 10, 0


section .text
global main
extern printf
extern scanf
extern stdout
extern fprintf

; TODO b: Define a function that returns the sum of all elements <= func argument
;         e.g. get_sum(10) = 55
get_sum:
    push ebp
    mov ebp, esp

    leave
    ret

; TODO d: Define a funcion that expects an argument and will return the number from
;         the Fibonacci sequence placed at the received index
;         e.g. get_fib(6) = 8 (Fib. seq: 1, 1, 2, 3, 5, 8)
;              get_fib(2) = 1 (Fib. seq: 1, 1)
get_fib:
    push ebp
    mov ebp, esp

    leave
    ret

main:
    push ebp
    mov ebp, esp


    ; TODO a: Read 2 integers, save them on the stack and print them

    ; TODO c: Call get_sum with the 2 numbers you saved on the stack
    ;         Print the results using **`fprintf`**.
    ;         Check the arguments `fprintf` expects (man fprintf).

    ; TODO d: Call get_fib with the 2 numbers you saved on the stack.
    ;         Print the results after that.

    ; Return 0.
    xor eax, eax
    leave
    ret
