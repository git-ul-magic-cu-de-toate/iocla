%include "../include/io.mac"

extern printf
global check_row
global check_column
global check_box
; you can declare any helper variables in .data or .bss

section .text


; int check_row(char* sudoku, int row);
check_row:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int row
    ;; DO NOT MODIFY

    ;; Freestyle starts here

    mov   eax, edx          ; use eax for offsetting the sudoku array
                            ; and also use it for values in sudoku row
    mov   ecx, 9            ; ecx - counter
    mul   ecx               ; get the row offset
    add   esi, eax          ; offset sudoku array to needed row

    xor   ebx, ebx          ; ebx will hold the sum of the row
                            ; sudoku rows, columns and boxes add up to 45
                            ; Is this Simon's secret?

loop_begin_row:
    cmp   ecx, 0
    je    loop_end_row

    mov al, [esi]           ; get value in sudoku row
                            ; check: 1 <= value <= 9
    cmp   eax, 1
    jl    invalid_row

    cmp   eax, 9
    jg    invalid_row

    add   ebx, eax          ; add the value to sum

    inc   esi               ; go to next value in sudoku array
    dec   ecx
    jmp   loop_begin_row

invalid_row:
    mov   eax, 2            ; set eax to invalid code(2)
    jmp   end_check_row

loop_end_row:
    cmp   ebx, 45           ; if row sum is 45 it's valid
    je    valid_row
    jmp   invalid_row

valid_row:
    mov   eax, 1            ; set eax to valid code(1)

    ;; Freestyle ends here
end_check_row:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret

    ;; DO NOT MODIFY

; int check_column(char* sudoku, int column);
check_column:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int column
    ;; DO NOT MODIFY

    ;; Freestyle starts here

    add   esi, edx          ; offset sudoku array to needed column

    xor   eax, eax          ; clear eax before using it
    xor   ebx, ebx          ; ebx will hold the sum of the column
                            ; sudoku rows, columns and boxes add up to 45
    mov   ecx, 9            ; ecx - counter

loop_begin_column:
    cmp   ecx, 0
    je    loop_end_column

    mov al, [esi]   ; get the value in sudoku column
                            ; check: 1 <= value <= 9
    cmp   eax, 1
    jl    invalid_column

    cmp   eax, 9
    jg    invalid_column

    add   ebx, eax          ; add the value to sum

    add   esi, 9            ; go to next value in sudoku array
    dec   ecx
    jmp   loop_begin_column

invalid_column:
    mov   eax, 2            ; set eax to invalid code(2)
    jmp   end_check_column

loop_end_column:
    cmp   ebx, 45           ; if row sum is 45 it's valid
    je    valid_column
    jmp   invalid_column

valid_column:
    mov   eax, 1            ; set eax to valid code(1)

    ;; Freestyle ends here
end_check_column:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret

    ;; DO NOT MODIFY


; int check_box(char* sudoku, int box);
check_box:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int box
    ;; DO NOT MODIFY

    ;; Freestyle starts here

                            ; get the offset (stored in eax)
                            ; offset = box_no / 3 * 27 + box_no % 3 * 3
    mov   eax, edx          ; eax = edx;
    xor   edx, edx          ; clear edx
    mov   ebx, 3            ; ebx = 3;
    div   ebx               ; eax = eax / ebx;

    mov   ecx, edx          ; store remainder in ecx

    mov   ebx, 27           ; ebx = 27;
    mul   ebx               ; eax = eax * ebx;
                            ; eax = edx / 3 * 27;
    mov   edx, eax          ; edx = eax |
    mov   eax, ecx          ; eax = ecx | => This was done because mul
    mov   ecx, edx          ; ecx = edx |        messes with edx
    mov   ebx, 3            ; ebx = 3
    mul   ebx               ; eax = eax * 3
    add   eax, ecx          ; now eax stores the offset needed

    add   esi, eax          ; offset sudoku array to needed box

    xor   ebx, ebx          ; ebx will hold the sum of the box
                            ; sudoku rows, columns and boxes add up to 45
    mov   ecx, 9            ; ecx - counter

loop_begin_box:
    cmp   ecx, 0
    je    loop_end_box

    cmp   ecx, 3
    je    offset_sudoku     ; every 3rd element we need to offset the sudoku

    cmp   ecx, 6
    je    offset_sudoku

continue_sudoku:

    mov al, [esi]           ; get the value in sudoku box
                            ; check: 1 <= value <= 9
    cmp   eax, 1
    jl    invalid_box

    cmp   eax, 9
    jg    invalid_box

    add   ebx, eax          ; add the value to sum

    inc   esi               ; go to next value in sudoku array
    dec   ecx
    jmp   loop_begin_box

offset_sudoku:
    add   esi, 6            ; offset sudoku char by 6
    jmp   continue_sudoku   ; to get to the next elem in box

invalid_box:
    mov   eax, 2            ; set eax to invalid code(2)
    jmp   end_check_box

loop_end_box:
    cmp   ebx, 45           ; if row sum is 45 it's valid
    je    valid_box
    jmp   invalid_box

valid_box:
    mov   eax, 1            ; set eax to valid code(1)

    ;; Freestyle ends here
end_check_box:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret

    ;; DO NOT MODIFY
