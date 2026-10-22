;; void print_array(int *arr, int len)
;; prints an array of ints(length len)
print_array:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]

    xor ecx, ecx

print_elem:
    pusha
    push dword[eax + 4 * ecx]
    push int_fmt
    call printf
    add esp, 8
    popa
    inc ecx
    cmp ecx, ebx
    jl print_elem

    push newline
    call printf
    add esp, 4

    leave
    ret

;; int get_fibo(int n)
;; returns the n-th fibo number
get_fib:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    cmp eax, 0
    jg fibo
    xor eax, eax
    leave
    ret

fibo:
    mov ecx, 0
    mov ebx, 0
    mov esi, 1
    mov edi, 1

fibo_loop:
    mov ebx, esi
    mov esi, edi
    add edi, ebx

    inc ecx
    cmp ecx, eax
    jl fibo_loop

    mov eax, ebx
    leave
    ret