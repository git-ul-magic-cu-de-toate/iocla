%include "../utils/printf32.asm"

section .data
source_text: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCB", 0    ;;;;; esi ;;;;;
substring: db "BABC", 0                                     ;;;;; edi ;;;;;

print_format: db "Substring found at index: %d", 10, 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    ; TODO: Print the start indices for all occurrences of the substring in source_text
    mov esi, source_text
    mov edi, substring

source_loop:
    mov eax, esi
    mov edx, edi

substr_loop:
    cmp byte [edx], 0       ; verific daca subsirul a ajuns la final
    je found_substr
    mov bl, byte [eax]      ; iau un byte din sirul mare
    cmp byte [edx], bl      ; il compar cu byte-ul din subsir
    jne exit_substr_loop    ; daca nu e la fel, caut mai departe
    inc eax
    inc edx
    jmp substr_loop

found_substr:               ; am ajuns la gasirea uneia dintre aparitii
    pusha
    mov ecx, esi            ; pun in ecx adresa la care s-a gasit prima aparitie
    sub ecx, source_text    ; aflu indexul
    push ecx                ; pun indexul pe stiva
    push print_format
    call printf             ; il afisez pe ecran
    add esp, 8
    popa

exit_substr_loop:
    inc esi                 ; merg la urmatoarea pozitie din sirul mare
    cmp byte [esi], 0       ; ma opresc daca ajung la finalul sirului mare
    je exit
    jmp source_loop

exit:
    leave
    ret
