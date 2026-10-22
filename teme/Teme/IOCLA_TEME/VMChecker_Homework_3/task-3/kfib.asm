section .text
global kfib

; eax - return value
; ebx - int n (1st function parameter)
; ecx - int K (2nd function parameter)
; edx - idx for loop
; esi - sum
; edi - tmp value
kfib:
    ; create a new stack frame
    enter 0, 0

    push ebx
    push esi
    push edi

    ; ebx = n
    mov ebx, [ebp + 8]
    ; ecx = K
    mov ecx, [ebp + 12]

    ; if (n < K) => return 0
    cmp ebx, ecx
    jl return_zero

    ; if (n == K) => return 1
    je return_one

    ; sum = 0
    xor esi, esi
    ; i = 1
    mov edx, 1

start_loop:
    cmp edx, ecx
    jg end_loop

    ; prepare recursive call - kfib(n - i, K)
    push eax
    push ecx
    push edx

    ; push K
    push ecx
    mov edi, ebx
    sub edi, edx
    ; push n - i
    push edi
    call kfib
    ; clean up stack
    add esp, 8

    pop edx
    pop ecx
    ; sum += result
    add esi, eax
    pop eax

    inc edx
    jmp start_loop

end_loop:
    mov eax, esi
    jmp end

return_zero:
    xor eax, eax
    jmp end

return_one:
    ; (n == K)
    mov eax, 1

end:
    pop edi
    pop esi
    pop ebx

    leave
    ret