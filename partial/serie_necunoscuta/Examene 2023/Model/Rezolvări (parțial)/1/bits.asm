%include "utils/printf32.asm"
extern printf

section .data
    num dd 55555123
    num2 dd 13456198
    fmt_int db "%d%d", 10, 0
    fmt_int_2 db "%d", 10, 0

section .text
global main

main:
    push ebp
    mov ebp, esp

    ;TODO a: print least significant 2 bits of the second most significant byte of num

    mov eax, [num]
    shl eax, 14
    shr eax, 30

    mov ebx, 1
    and ebx, eax

    shr eax, 1
    mov ecx, 1
    and ecx, eax

    push ebx
    push ecx
    push fmt_int
    call printf
    add esp, 12

    ;TODO b: print number of bits set on odd positions

    mov eax, [num]
    xor ecx, ecx
    xor esi, esi

loop_b:
    cmp ecx, 32
    je end_b

    mov ebx, 1
    and ebx, eax
    cmp ebx, 1
    jne skip

    inc esi

skip:
    shr eax, 2
    inc ecx
    jmp loop_b

end_b:

    push esi
    push fmt_int_2
    call printf
    add esp, 8

    ;TODO c: print number of groups of 3 consecutive bits set

    mov eax, [num]
    xor ecx, ecx
    xor esi, esi

loop_c:
    cmp ecx, 32
    je end_c

    mov ebx, 1
    and ebx, eax
    cmp ebx, 1
    jne skip_c

    mov edi, eax
    shr edi, 1
    mov ebx, 1
    and ebx, edi
    cmp ebx, 1
    jne skip_c

    shr edi, 1
    mov ebx, 1
    and ebx, edi
    cmp ebx, 1
    jne skip_c

    inc esi

skip_c:
    shr eax, 1
    inc ecx
    jmp loop_c

end_c:

    push esi
    push fmt_int_2
    call printf
    add esp, 8

    xor eax, eax
    leave
    ret
