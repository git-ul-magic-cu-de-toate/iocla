%include "../include/io.mac"

;; defining constants, you can use these as immediate values in your code
LETTERS_COUNT EQU 26

section .data
    extern len_plain

section .text
    global rotate_x_positions
    global enigma
    extern printf

; void rotate_x_positions(int x, int rotor, char config[10][26], int forward);
rotate_x_positions:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; x
    mov ebx, [ebp + 12] ; rotor
    mov ecx, [ebp + 16] ; config (address of first element in matrix)
    mov edx, [ebp + 20] ; forward
    ;; DO NOT MODIFY
    ;; TODO: Implement rotate_x_positions
    ;; FREESTYLE STARTS HERE


    ; forward = 0 => end
    cmp eax, 0
    je  end
    
    ; check forward
    cmp edx, 0
    je  find_rotor

    ; check forward
    cmp edx, 1
    je  find_rotor_r


; rotate for specified rotor
find_rotor:
    
    ; put rotor here
    mov ebx, [ebp + 12]

    ; rotor_0
    cmp ebx, 0
    je ro0
    ; rotor_1
    cmp ebx, 1
    je ro1
    ; rotor_2
    cmp ebx, 2
    je ro2
    
ro0:
    mov esi, 0
    xor ebx, ebx
    mov ebx, [ebp + 8]
    jmp repeat_shift

ro1:
    mov esi, 52
    xor ebx, ebx
    mov ebx, [ebp + 8]
    jmp repeat_shift
    
ro2:
    mov esi, 104
    xor ebx, ebx
    mov ebx, [ebp + 8]
    jmp repeat_shift

repeat_shift:
    

offset:
    
    ; address of first element
    mov edi, [ebp + 16]
    ; add padding
    add edi, esi
    ; make ecx counter
    xor ecx, ecx


bucla:

    cmp ecx, 0
    je  start_row1

    cmp ecx, 26
    je  start_row2

    jmp normal_row


start_row1:

    ; store LAST LETTER
    mov al, [edi + ecx + 26]
    inc ecx
    dec edi
    jmp bucla

start_row2:
    
    ; set margins
    mov ah, byte [edi + 26]
    mov byte [edi + 26], al
    mov byte [edi + 26 + 25], ah

    ; store LAST LETTER
    add edi, 52
    mov al, [edi + ecx + 26]
    inc ecx
    dec edi
    jmp bucla

normal_row:

    ; store PEN LETTER (25)
    mov ah, byte [edi + 26]
    ; PEN LETTER = LAST LETTER
    mov byte [edi + 26], al
    ; LAST LETTER = PEN LETTER
    mov al, ah

    inc ecx
    dec edi
    cmp ecx, 52
    jne bucla

    ; set margins
    mov ah, byte [edi + 26]
    mov byte [edi + 26], al
    mov byte [edi + 26 + 25], ah

    dec ebx
    cmp ebx, 0
    jne repeat_shift
    jmp end

find_rotor_r:
    
    ; put rotor here
    mov ebx, [ebp + 12]

    ; find rotor_for_right_shift
    cmp ebx, 0
    je ro0_r

    cmp ebx, 1
    je ro1_r

    cmp ebx, 2
    je ro2_r
    

ro0_r:
    mov esi, 0
    xor ebx, ebx
    mov ebx, [ebp + 8]
    jmp repeat_shift_r

ro1_r:
    mov esi, 52
    xor ebx, ebx
    mov ebx, [ebp + 8]
    jmp repeat_shift_r
    
ro2_r:
    mov esi, 104
    xor ebx, ebx
    mov ebx, [ebp + 8]
    jmp repeat_shift_r

repeat_shift_r:
    

offset_r:
    
    ; address of first element
    mov edi, [ebp + 16]
    ; add padding
    add edi, esi
    ; make ecx counter
    xor ecx, ecx

bucla_r:

    cmp ecx, 0
    je  start_row1_r

    cmp ecx, 26
    je  start_row2_r

    jmp normal_row_r


start_row1_r:

    ; store FIRST LETTER
    mov al, [edi + ecx]
    inc ecx
    jmp bucla_r

start_row2_r:
    
    ; set margins
    mov byte [edi + ecx - 26], al 
    mov al, [edi + ecx]
    inc ecx
    jmp bucla_r

normal_row_r:

    ; store SECOND LETTER (2)
    mov ah, byte [edi + ecx]
    ; SECOND LETTER = FIRST LETTER
    mov byte [edi + ecx], al
    ; FIRST LETTER = SECOND LETTER
    mov al, ah

    inc ecx
    cmp ecx, 52
    jne bucla_r

    ; set margins
    mov byte [edi + ecx - 26], al 

    dec ebx
    cmp ebx, 0
    jne repeat_shift_r

end:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY


    popa
    leave
    ret
    ;; DO NOT MODIFY

; void enigma(char *plain, char key[3], char notches[3], char config[10][26], char *enc);
enigma:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; plain (address of first element in string)
    mov ebx, [ebp + 12] ; key
    mov ecx, [ebp + 16] ; notches
    mov edx, [ebp + 20] ; config (address of first element in matrix)
    mov edi, [ebp + 24] ; enc
    ;; DO NOT MODIFY
    ;; TODO: Implement enigma
    ;; FREESTYLE STARTS HERE


    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY