%include "utils/printf32.asm"
extern printf

section .data

arr dd 9, 7, 100, 20, 90, 97, 192, 1000, 256, 999
N equ 10
Q dd 3

section .bss

; TODO c:
;   - definiti vectorul res1 cu elemente de tip dword si dimensiunea maxima egala cu N
;   - definiti variabla len1 de tipul dword care va retine dimensiunea efectiva a vectorului res1

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Afisati restul impartirii elementului arr[7] la numarul referit de adresa Q
    ; Reamintim folosirea instructiunii div
    ; dividend  -> EDX : EAX
    ; divisor   -> r/m32
    ; quotient  -> EAX
    ; remainder -> EDX

    ; TODO b: Calculați și afișați suma numerelor divizibile cu 3 din vectorul arr

    ; TODO c: Completati vectorul `res1` cu elementele din vectorul arr
    ; care dau restul 1 la impartirea cu 3.
    ; Retineti dimensiunea vectorului `res1` in variabila len1

    ; TODO d: Afisati elementele vectorului `res1` tinand cont de dimensiunea
    ; acestuia retinuta in variabila `len` la todo c)

    ; Return 0.
    xor eax, eax
    leave
    ret
