%include "../utils/printf32.asm"

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov eax, 230    ; to be broken down into powers of 2
    mov ebx, 1      ; stores the current power

    ; TODO - print the powers of 2 that generate number stored in EAX
start:
    test eax, ebx ; fac SI logic
    jz next       ; trec peste daca nu exista biti comuni

    PRINTF32 `%d\n\x0`, ebx

next:
    shl ebx, 1  ; shiftez masca la stanga cu 1 ca sa compar bitii

    cmp ebx, eax ; ma opresc cand ebx depaseste nr initial
    jl start   ; daca inca nu a ajuns la 32, continui programul

    leave
    ret
