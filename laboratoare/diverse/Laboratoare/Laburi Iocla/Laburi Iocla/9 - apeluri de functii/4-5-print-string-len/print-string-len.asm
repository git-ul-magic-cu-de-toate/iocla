%include "../utils/printf32.asm"

section .data
    mystring db "This is my string", 0
    print_format db "String length is %d", 10, 0
    store_string times 64 db 0

section .text

extern puts
extern printf
global main

;; void reverse_string(const char *src, size_t len, char *dst) ;;
reverse_string:
    push ebp
    mov ebp, esp

    mov eax, dword [ebp+8]      ; sirul sursa
    mov ecx, dword [ebp+12]     ; lungimea sirului
    add eax, ecx                ; pointez la finalul sirului sursa
    dec eax
    mov edx, dword [ebp+16]     ; sirul destinatie

copy_one_byte:
    mov bl, byte [eax]
    mov byte [edx], bl          ; mut cate un byte in sirul destinatie
    dec eax
    inc edx
    loopnz copy_one_byte

    inc edx                     ; plasare terminator de sir
    mov byte [edx], 0

    leave
    ret

main:
    push ebp
    mov ebp, esp

    mov eax, mystring
    xor ecx, ecx
test_one_byte:
    mov bl, byte [eax]
    test bl, bl
    je out
    inc eax
    inc ecx
    jmp test_one_byte

out:
    PRINTF32 `[PRINTF32]: %d\n[printf]: \x0`, ecx
    push ecx                ; save ecx pentru ca poate fi modificat de printf
    push ecx                ; intai se pune lungimea
    push print_format       ; apoi mesajul
    call printf
    add esp, 8

    ;; reversed string: ;;
    pop ecx
    push store_string       ; destinatie
    push ecx                ; lungime
    push mystring           ; sursa
    call reverse_string
    add esp, 12

    push store_string
    call puts 
    add esp, 4


    leave
    ret
