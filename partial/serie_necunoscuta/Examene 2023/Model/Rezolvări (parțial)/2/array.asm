%include "utils/printf32.asm"

extern printf

section .data
    num dd 55555123
;;  TODO d: declare byte_array so that PRINT_HEX shows babadac 
byte_array db 0  
fmt_char db "%c ",0
fmt_newline db 10, 0
	
section .text
global main

; TODO b: implement array_reverse
array_reverse:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8] ; arr
    mov edi, [ebp + 12] ; length

    xor ecx, ecx ; contor pentru loop

loop_b:
    cmp ecx, edi
    je prep_swap

    mov bl, [eax + ecx]
    push ebx

    inc ecx
    jmp loop_b

prep_swap:
    xor ecx, ecx ; reinitializez contorul

swap:
    cmp ecx, edi
    je init_print_b

    ;xor ebx, ebx
    pop ebx
    mov [eax + ecx], bl

    inc ecx
    jmp swap

init_print_b:
    xor ecx, ecx
    ;xor ebx, ebx

print_b:    
    cmp ecx, edi
    je end_b

    xor ebx, ebx
    mov bl, [eax + ecx]

    push ecx

    push ebx
    push fmt_char
    call printf
    add esp, 8

    pop ecx

    inc ecx
    jmp print_b

end_b:
    push fmt_newline
    call printf
    add esp, 4

    leave
    ret

; TODO c: implement pow_arraypowArray
pow_array:

main:
    push ebp
    mov ebp, esp

    ;TODO a: allocate on array of 20 byte elements and initializate it incrementally starting from 'A'
    sub esp, 20
    xor ecx, ecx ; contor
    mov ebx, 'A'

loop_a:
    cmp ecx, 20
    je init_print_a
    
    mov [esp + ecx], bl

    inc ebx
    inc ecx
    jmp loop_a

init_print_a:
    xor ecx, ecx
    xor ebx, ebx

print_a:
    cmp ecx, 20
    je end_a

    mov bl, [esp + ecx]

    push ecx

    push ebx
    push fmt_char
    call printf
    add esp, 8

    pop ecx

    inc ecx
    jmp print_a

end_a:
    push fmt_newline
    call printf
    add esp, 4

    ;TODO b: call array_reverse and print reversed array
    mov ebx, esp
    push dword 20
    push ebx
    call array_reverse
    add esp, 8

    ;TODO c: call pow_array and print the result array

	;;  TODO d: this print of an uint32_t should print babadac 
	;PRINTF32 `%x\n\x0`, byte_array 

    xor eax, eax
    leave
    ret
