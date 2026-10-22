
extern printf

section .data

int_fmt_newline db "%d ", 10, 0
int_fmt db "%d ", 0
newline_fmt db 10, 0

N dd 12349
arr dd 12341, 2, 3123, 1914, 99995, 6666, 7, 88, 129, 10000
len equ 10

section .bss

;TODO b: Reserve memory for an array named `res` storing  `len` integers
;Hint: `len` is the number of elements. Compute the correct memory size to be reserved.
res resd len

section .text
global main

; TODO a: Implement `int get_last_digit(unsigned int n)` function that returns the last digit of number `n`

; NOTE: div instruction
; dividend EDX:EAX, divisor register or memory 32 => Results: Quotient in EAX, Remainder in EDX

; Hint:  to find the last digit we divide the given number by 10 and look at the reminder
get_last_digit:
    push ebp
    mov ebp, esp

    xor edx, edx

    mov eax, [ebp + 8]

    mov ebx, 10
    div ebx
    
    leave
    ret

;TODO c: Implement `int compute_sum_digits(unsigned int n)` function that computes the sum of digits found in `n`
compute_sum_digits:
    push ebp
    mov ebp, esp


    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Call `get_last_digit(N)`. Use N from `.data` section.
    ; Print the result using `printf` function. You may use `int_fmt_newline` defined in `.data` section
    
    push dword [N]
    call get_last_digit
    add esp, 4

    push edx
    push int_fmt_newline
    call printf
    add esp, 8

    ; TODO b: Compute the last digit for all `len` elements of `arr` array and store the results in `res` array.
    ; Thus res[i] = get_last_digit(arr[i])
    mov ecx, 0
    .for_loop:
    push dword [arr + ecx * 4]
    call get_last_digit
    add esp, 4

    mov [res + ecx * 4], edx

    inc ecx
    cmp ecx, len
    jl .for_loop



    ; TODO c: Print all the elements of `res` array with `len` elements on the same line separated by space.
    ; You must add a newline at the end. Use `newline_fmt` string defined in `.data` section.
    ; You must call`printf` function for printing. You may use `int_fmt` defined in `.data` section
    mov ecx, 0
.for_loop2:
    push ecx

    push dword [res + ecx * 4]
    push int_fmt
    call printf
    add esp, 8

    pop ecx

    inc ecx
    cmp ecx, len
    jl .for_loop2

    push newline_fmt
    call printf
    add esp, 4

    ; TODO d: Compute and print the sum of digits of number `N`.
    ; Use printf for printing. You may use `int_fmt_newline` defined in `.data` section.
    mov eax, 0
    mov ecx, 0
.for_loop3:
    add eax, [res + ecx * 4]

    inc ecx
    cmp ecx, len
    jl .for_loop3

    push eax
    push int_fmt_newline
    call printf
    add esp, 8


    ; Return 0.
    xor eax, eax
    leave
    ret