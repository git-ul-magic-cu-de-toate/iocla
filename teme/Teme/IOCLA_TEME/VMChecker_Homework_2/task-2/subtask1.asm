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

section .data
    months db 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31

section .text
    global check_events
    extern printf

check_events:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov ebx, [ebp + 8]      ; events
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here

loop_begin:
    cmp ecx, 0
    je  loop_end

    mov ax, [ebx + date + month]    ; get the year
                                    ; check 1990 <= year <= 2030
    cmp ax, 1990
    jl  invalid_date

    cmp ax, 2030
    jg  invalid_date

    mov al, [ebx + date + year]     ; get month
                                    ; check 1 <= month <= 12
    cmp al, 1
    jl  invalid_date

    cmp al, 12
    jg  invalid_date

    dec al                          ; normalise index of months vector
    mov dl, [months + eax]          ; get no of days in said month
    mov al, [ebx + date]            ; get day
                                    ; check 1 <= day <= month length
    cmp al, 1
    jl  invalid_date

    cmp al, dl
    jg  invalid_date

    mov byte [ebx + name], 1        ; set valid flag to 1

    dec ecx                         ; advance in events
    add ebx, event_t_size
    jmp loop_begin

invalid_date:
    mov byte [ebx + name], 0        ; set valid flag to 0

    dec ecx
    add ebx, event_t_size           ; advance in events
    jmp loop_begin

loop_end:

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY