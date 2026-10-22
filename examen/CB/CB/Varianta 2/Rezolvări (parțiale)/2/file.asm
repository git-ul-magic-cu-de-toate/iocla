section .bss
    num1 resd 1
    num2 resd 1

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

    mov edi, [ebp + 8] ; nr
    xor ecx, ecx ; contor
    xor eax, eax ; suma
    cmp edi, 0
    jl end_b

loop_b:
    cmp ecx, edi
    jg end_b

    add eax, ecx

    inc ecx
    jmp loop_b

end_b:
    leave
    ret

; TODO d: Define a funcion that expects an argument and will return the number from
;         the Fibonacci sequence placed at the received index
;         e.g. get_fib(6) = 8 (Fib. seq: 1, 1, 2, 3, 5, 8)
;              get_fib(2) = 1 (Fib. seq: 1, 1)
get_fib:
    push ebp
    mov ebp, esp

    mov edx, [esp + 8]; nr
    mov edi, 1 ; primul termen
    mov esi, 1 ; al doilea termen
    dec edx ; am de facut nr - 1 iteratii

loop_d:
    

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Read 2 integers, save them on the stack and print them
    xor eax, eax
    xor ebx, ebx

    push num1
    push int_fmt
    call scanf
    add esp, 8

    push dword [num1]

    push dword [num1]
    push int_fmt
    call printf
    add esp, 8

    push num2
    push int_fmt
    call scanf
    add esp, 8

    push dword [num2]

    push dword [num2]
    push int_fmt
    call printf
    add esp, 8

    ; TODO c: Call get_sum with the 2 numbers you saved on the stack
    ;         Print the results using **`fprintf`**.
    ;         Check the arguments `fprintf` expects (man fprintf).

    call get_sum
    add esp, 4

    push eax
    push int_fmt
    push dword [stdout]
    call fprintf
    add esp, 12

    call get_sum
    add esp, 4

    push eax
    push int_fmt
    push dword [stdout]
    call fprintf
    add esp, 12

    ; TODO d: Call get_fib with the 2 numbers you saved on the stack.
    ;         Print the results after that.

    ; Return 0.
    xor eax, eax
    leave
    ret
