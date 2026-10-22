%include "../include/io.mac"

; declare your structs here
struc date_t
    day: resb 1
    month: resb 1
    year: resw 1
endstruc

struc event_t
    name: resb 31
    valid: resb 1
    date: resb date_t_size
endstruc

section .text
    global sort_events
    extern printf

sort_events:
    ;; DO NOT MODIFY
    enter 0, 0
    pusha

    mov ebx, [ebp + 8]      ; events
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
jmp skip
    mov edi, [ebp + 8]
    ; mov esi, [ebp + 8]

    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    ; dl will be used as a counter for the 1st loop
    ; dh will be used as a counter for the 2nd loop
    ; dl = i
    ; dh = j

first_loop: ; for (int i = 0; i < c; i++)
    cmp dl, cl ; i < c
    je first_loop_end ; i == c

    mov dh, dl
    inc dh ; j = i + 1

    second_loop: ; for (int j = i + 1; j < c; j++)
        cmp dh, cl ; j < c
        je second_loop_end ; j == c

        ; event[i]
        mov al, dl
        imul eax, event_t_size
        lea edx, [edi + eax]

        ; event[j]
        mov al, dh
        imul eax, event_t_size
        lea eax, [edi + eax]

        ; xor eax, eax

        push ecx
        mov cl, [edx]
        cmp cl, [eax]
        pop ecx
        jl swap_element ; case 0 < 1
        ; je sort_by_date ; case 1 = 1, 0 = 0

        inc dh ; j++
        jmp second_loop
    second_loop_end:

    inc dl ; i++
    jmp first_loop
first_loop_end:

; sort_by_date:

swap_element:
    xor esi, esi ; used as counter

    swap_loop: ; swap byte by byte
        cmp esi, event_t_size
        jg swap_loop_end

        inc esi
        jmp swap_loop

    swap_loop_end:

    inc dh ; j++
    jmp second_loop
skip:
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY