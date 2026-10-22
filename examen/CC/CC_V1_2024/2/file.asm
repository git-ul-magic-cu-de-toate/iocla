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

    mov eax, [ebp + 8]    ; Get the argument (n) into eax

    cmp eax, 1            ; Compare n with 1
    jle base_case         ; If n <= 1, jump to base_case

    sub eax, 1            ; n = n - 1
    push eax              ; Push (n - 1) onto the stack
    call fibo             ; Recursive call fibo(n - 1)
    add esp, 4            ; Clean up the stack

    mov ecx, eax          ; Save the result of fibo(n - 1) in ecx

    mov eax, [ebp + 8]    ; Get the argument (n) again into eax
    sub eax, 2            ; n = n - 2
    push eax              ; Push (n - 2) onto the stack
    call fibo             ; Recursive call fibo(n - 2)
    add esp, 4            ; Clean up the stack

    add eax, ecx          ; eax = fibo(n - 1) + fibo(n - 2)
    jmp end_fibo          ; Jump to end_fibo

base_case:
    mov eax, 1            ; If n <= 1, fibo(n) = 1

end_fibo:

;     mov eax, [ebp + 8]
    
;     cmp eax, 1
;     jne recurs
;     jmp end_fibo

;     cmp eax, 2
;     jne recurs
;     mov eax, 1
;     jmp end_fibo

; recurs:
;     dec eax
;     push eax
;     call fibo
;     add esp, 4

;     mov ecx, eax

;     pusha
;     push eax
;     push fmt_int_newline
;     call printf
;     add esp, 8
;     popa

;     mov eax, [ebp + 8]
;     sub eax, 2
;     push eax
;     call fibo
;     add esp, 4

;     pusha
;     push eax
;     push fmt_int_newline
;     call printf
;     add esp, 8
;     popa

;     add eax, ecx

; end_fibo:
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
    push 5
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
