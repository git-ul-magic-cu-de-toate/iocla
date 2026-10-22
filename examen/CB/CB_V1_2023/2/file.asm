section .data
    string_fmt: db "%s", 0
    int_fmt: db "%d ", 0
    newline_fmt: db 10, 0
    cmp_string: db "AnaAreMere", 0
    test_number_true: db "12345", 0
    test_number_false: db "12b23", 0

section .bss
    ; TODO a: Reserve space for string
    string: resb 100
section .text
global main
extern printf
extern scanf

; TODO b: Implement `my_strcmp`
my_strcmp:
    push ebp
    mov ebp, esp

    mov edx, [ebp + 8]
    mov ebx, [ebp + 12]

    xor esi, esi

loop3:
    mov al, byte [edx + esi] 
    mov cl, byte [ebx + esi]

    cmp al, 0
    je test_ebx

    cmp cl, 0
    je greater

    cmp al, cl 
    jg greater
    jl lower

    inc esi
    jmp loop3

test_ebx:
    cmp cl, 0
    je equal
    jmp lower

greater:
    mov eax, 1
    jmp end_strcmp

lower:
    mov eax, -1
    jmp end_strcmp

equal:
    xor eax, eax

end_strcmp:
    leave
    ret

; TODO c: Implement `is_number`
is_number:
    push ebp
    mov ebp, esp

    sub esp, 4                  ; Allocate space for a local variable

    mov edx, [ebp + 8]          ; Load the address of the string into edx

    xor esi, esi                ; Initialize index register to 0

check_loop:
    mov al, byte [edx + esi]    ; Load the byte at [edx + esi] into al
    cmp al, 0                   ; Check if we have reached the end of the string
    je all_digits               ; If yes, the string contains only digits

    cmp al, '0'                 ; Check if the character is less than '0'
    jl not_digit
    cmp al, '9'                 ; Check if the character is greater than '9'
    jg not_digit

    inc esi                     ; Move to the next byte
    jmp check_loop              ; Repeat the loop

not_digit:
    mov eax, 0                  ; Return 0 if a non-digit character is found
    jmp end_function

all_digits:
    mov eax, 1                  ; Return 1 if all characters are digits

end_function:

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Read a string from stdin then print it
    pusha
    push string
    push string_fmt
    call scanf
    add esp, 8
    popa

    pusha
    push string
    push string_fmt
    call printf
    add esp, 8
    popa

    pusha
    push newline_fmt
    call printf
    add esp, 4
    popa

    ; TODO c: Call `is_number` with `test_number_true` and `test_number_false`
    ;         as parameters. Print the results, first call should print 1,
    ;         second call should print 0.

    push test_number_false
    call is_number
    add esp, 4

    pusha
    push eax
    push int_fmt
    call printf
    add esp, 8
    popa

    pusha
    push newline_fmt
    call printf
    add esp, 4
    popa

    ; TODO d: Call `my_strcmp(buffer_from_a, cmp_string)`
    ; pusha
    push cmp_string
    push string
    call my_strcmp
    add esp, 8
    ; popa

    pusha
    push eax
    push int_fmt
    call printf
    add esp, 8
    popa

    ; Return 0.
    xor eax, eax
    leave
    ret
