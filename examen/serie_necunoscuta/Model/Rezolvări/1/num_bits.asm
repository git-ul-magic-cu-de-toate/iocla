%include "utils/printf32.asm"
extern printf


section .data
    arr1 db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x99, 0x88
    len1 equ $-arr1
    arr2 db 0x12, 0x34, 0x56, 0x78, 0x90, 0xab, 0xcd, 0xef
    len2 equ $-arr2
    val1 dd 0xabcdef01
    val2 dd 0x62719012

    bit_set_fmt db "sign bit", 10, 0
    bit_not_set_fmt db "no sign bit", 10, 0
    int_fmt db "%d ", 10, 0


section .text
global main


main:
    push ebp
    mov ebp, esp


    ; TODO a: Print if sign bit is present or not.
    mov eax, [val2]
    shr eax, 31
    cmp eax, 0
    je bit_not_set
    
    push bit_set_fmt
    call printf
    add esp, 4
    jmp end_a

bit_not_set:
    push bit_not_set_fmt
    call printf
    add esp, 4

end_a:

    ; TODO b: Prin number of bits for integer value.

    mov eax, [val2]
    xor ecx, ecx ; contor pentru loop
    xor edi, edi ; contor pentru nr biti

loop_b:
    cmp ecx, 32
    je end_b

    xor ebx, ebx
    mov ebx, 1
    shl ebx, cl

    and ebx, eax
    cmp ebx, 0
    je no_count

    inc edi

no_count:
    inc ecx
    jmp loop_b

end_b:
    push edi
    push int_fmt
    call printf
    add esp, 8

    ; TODO c: Prin number of bits for array.

    xor esi, esi
    xor eax, eax

    mov esi, arr2
    xor edx, edx ; contor pt loop
    xor edi, edi ; contor pt nr de biti

loop_c:
    xor ecx, ecx
    cmp edx, len2
    je end_c

loop_2_c:
    cmp ecx, 32
    je prepare_for_loop_c

    xor eax, eax
    mov al, byte [esi + ecx]
    xor ebx, ebx
    mov ebx, 1
    shl ebx, cl

    and ebx, eax
    cmp ebx, 0
    je no_count_c

    inc edi

no_count_c:
    inc ecx
    jmp loop_2_c

prepare_for_loop_c:
    inc edx
    jmp loop_c

end_c:
    push edi
    push int_fmt
    call printf
    add esp, 8

    ; Return 0.
    xor eax, eax
    leave
    ret
