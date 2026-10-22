%include "printf32.asm"

section .data
    n dd 4261543935
    arr1 dd 4294574079, 1073741823, 0, 1, 2, 3
    len1 equ $-arr1
    arr2 db 1, 0, 1, 1, 1, 0
    len2 equ $-arr2


section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp


    ; TODO a: Determine how many bits are not set for n
    ; HINT: Use not and popcnt

    push dword [n]
    call bits_not_set
    add esp, 4
    PRINTF32 `%d\n\x0`, eax

    ; TODO b: Determine how many values from arr1 don't have 2 bits not set

    xor ecx, ecx  ; index
    xor ebx, ebx ; numar
    mov edx, 6 ; numar elem in arr1
loop_b:
    cmp ecx, edx
    jge end_loop_b

    push ecx
    push ebx
    push edx
    push dword [arr1 + 4 * ecx]
    call bits_not_set
    add esp, 4
    pop edx
    pop ebx
    pop ecx

    cmp eax, 2
    je next_iter_b
    inc ebx

next_iter_b:
    inc ecx
    jmp loop_b

end_loop_b:
    PRINTF32 `%d\n\x0`, ebx

    ; TODO c: Calculate the decimal value of a number whose bits
    ; are stored in big endian order inside arr2
    xor ecx, ecx  ; index
    xor ebx, ebx ; contor
    mov edx, 6 ; numar elem in arr1
loop_c:
    cmp ecx, edx
    jge end_loop_c

    movzx esi, byte [arr2 + ecx]

    mov edi, edx
    sub edi, ecx
    sub edi, 1
    mov [n], edi
    
    pusha
    push n
    call pow2
    add esp, 4
    popa

    mov edi, [n]
    imul edi, esi
    add ebx, edi

next_iter_c:
    inc ecx
    jmp loop_c

end_loop_c:    
    PRINTF32 `%d\n\x0`, ebx


    ; Return 0.
    xor eax, eax
    leave
    ret

bits_not_set:
    push ebp
	mov ebp, esp

    mov eax, [ebp + 8]
    xor ecx, ecx ; contor
    xor edx, edx

loop_a1:
    cmp edx, 31
    jg end_loop_a1

    mov ebx, eax
    and ebx, 1
    cmp ebx, 0
    jne next_iter_a1
    inc ecx

next_iter_a1:
    shr eax, 1
    inc edx
    jmp loop_a1

end_loop_a1:
    mov eax, ecx

    leave
    ret

pow2:
    push ebp
    mov ebp, esp

    mov edx, [ebp + 8]  ; N
    mov ecx, [edx]

    mov eax, 1

    cmp dword [edx], 0
    je end_pow10

loop4:
    imul eax, 2
    loop loop4
    
end_pow10:
    mov [edx], eax
    
    leave
    ret
