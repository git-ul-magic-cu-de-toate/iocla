; DO NOT MODIFY THIS FILE
section .text

global solve
global check_string
;global catch_me

extern printf
extern strlen
extern gets
extern exit

solve:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov edx, [ebp + 12]
    xor edx, 0xCAFE     ; ? xor 1100101011111110 = 10010000101010010    ---> 0101101001010111      23127
    xor eax, 0xBABE     ; ? xor 1011101010111110 = 10100000100010000    ---> 0001101000110110       6710

    or edx, 0xDEAD      ; 12152 negatul 10010000101010010
    or eax, 0xBEEF      ; 14107 negatul 10100000100010000
    sub eax, edx

    leave
    ret

check_string:
    push ebp
    mov ebp, esp

    ; preserve ebx forced by C calling convention
    push ebx

    mov esi, [ebp + 8]   ; s
    cmp byte [esi + 2], 'P'
    jne invalid

    push esi
    call strlen
    add esp, 4
    dec eax
    
    mov esi, [ebp + 8]   ; s
    cmp byte [esi + eax - 2], 'Q'
    jne invalid

    xor edx, edx
    xor ebx, ebx
    xor ecx, ecx 

counter:
    cmp byte [esi + ecx], 0
    je check
    
    mov al, byte [esi + ecx]
    cmp al, 'A'
    jb next
    cmp al, 'Z'
    ja lower_check
    
    inc edx
    jmp next


lower_check:
    cmp al, 'a'
    jb next
    cmp al, 'z'
    ja next
    inc ebx

next:
    inc ecx
    jmp counter
    
check:
    cmp edx, 4
    jb invalid
    cmp ebx, 2      
    jb invalid
    jmp valid
  
invalid:
    mov eax, -1
    jmp end

valid:
    mov eax, 0

end:
    ; restore ebx
    pop ebx

    leave
    ret

