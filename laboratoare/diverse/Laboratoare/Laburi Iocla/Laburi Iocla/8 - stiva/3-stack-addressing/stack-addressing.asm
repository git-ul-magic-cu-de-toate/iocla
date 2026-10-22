%include "../utils/printf32.asm"

%define NUM 5
   
section .text

extern printf
global main
main:
    mov ebp, esp

    ; TODO 1: replace every push by an equivalent sequence of commands (use direct addressing of memory. Hint: esp)
    mov ecx, NUM
push_nums:
    ; push ecx
    sub esp, 4
    mov dword [esp], ecx
    loop push_nums

    ; push 0
    ; push "mere"
    ; push "are "
    ; push "Ana "
    sub esp, 4
    mov dword [esp], 0
    sub esp, 4
    mov dword [esp], "mere"
    sub esp, 4
    mov dword [esp], "are "
    sub esp, 4
    mov dword [esp], "Ana "
    
    ; lea esi, [esp]
    ; PRINTF32 `%s\n\x0`, esi

    ; TODO 2: print the stack in "address: value" format in the range of [ESP:EBP]
    ; use PRINTF32 macro - see format above
    mov eax, esp
print_addr:
    xor ebx, ebx                            ; fac loc in ebx sa pun cate un caracter
    mov bl, byte [eax]                      ; iau un byte din pozitia curenta de pe stiva (de ex daca la [eax] am "Ana", bl = 'A')
    PRINTF32 `0x%x: %d\n\x0`, eax, ebx      ; eax = adresa, ebx caracterul in ascii
    inc eax                                 ; ma duc la urmatorul caracter
    cmp eax, ebp                            ; ma opresc daca eax atinge baza stivei
    jl print_addr

    ; TODO 3: print the string
    lea esi, [esp]                          ; ia stringul ce incepe de la top-ul stivei
    PRINTF32 `%s\n\x0`, esi

    ; TODO 4: print the array on the stack, element by element.
    add esp, 16
print_numbers:
    pop eax
    PRINTF32 `%d \x0`, eax
    cmp esp, ebp
    jne print_numbers
    PRINTF32 `\n\x0`

    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp

    ; exit without errors
    xor eax, eax
    ret
