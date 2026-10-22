;; functia is_divisor(int n, int i)
;; determina daca un numar este divizor al altui numar
is_divisor:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]  ; n
    mov ecx, [ebp + 12] ; i

    ;; sectiunea de impartire a unui numar
    xor edx, edx 
    mov eax, ebx
    div ecx

    mov eax, edx
    cmp eax, 0
    je one

    xor eax, eax
    leave
    ret
one:
    mov eax, 1
    leave
    ret

;; functia count_divisors(int n) 
;; numara toti divizorii lui n (mai putin 1 si n)
count_divisors:
    push ebp
    mov ebp, esp

    mov ecx, [ebp + 8] ; n
    mov edx, ecx
    xor ebx, ebx
loop_n:
    push ebx
    push ecx
    push edx
    call is_divisor
    pop edx
    pop ecx
    pop ebx
    add ebx, eax
    loop loop_n

    mov eax, ebx
    sub eax, 2
    leave
    ret