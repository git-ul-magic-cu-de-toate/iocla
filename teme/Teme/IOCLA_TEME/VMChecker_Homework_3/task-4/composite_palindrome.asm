section .text
global check_palindrome
global composite_palindrome

check_palindrome:
    ; create a new stack frame
    enter 0, 0
    push ebx
    push edi
    push esi

    xor eax, eax
    xor ebx, ebx

    ; esi - pointer to str
    mov esi, [ebp + 8]
    ; ecx - len
    mov ecx, [ebp + 12]

    ; ecx = j = len - 1
    ; edi = i = 0
    dec ecx
    xor edi, edi

loop_start:
    ; if i >= j, it's a palindrome
    cmp edi, ecx
    jge loop_end

    ; str[i]
    ; str[j]
    mov al, [esi + edi]
    mov bl, [esi + ecx]

    cmp al, bl
    jne not_palindrome

    ; i++;
    ; j--;
    inc edi
    dec ecx
    jmp loop_start

loop_end:
    ; return 1;
    mov eax, 1
    jmp end

not_palindrome:
    ; return 0;
    xor eax, eax

end:
    pop esi
    pop edi
    pop ebx
    leave
    ret

composite_palindrome:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax
    leave
    ret
