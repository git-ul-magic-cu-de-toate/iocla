%include "../include/io.mac"

section .data

section .text
	global checkers
    extern printf


checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x (linia)
    mov ebx, [ebp + 12]	; y (coloana)
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

; verificam daca
x:
    ; x ul e 0
    cmp eax, 0
    je x_0
    ; x ul e 7
    cmp eax, 7
    je x_7

    ; trecem la y
    jmp y

x_0:
    ; y ul e 0
    cmp ebx, 0
    je x_0_y_0
    ; y ul e 7
    cmp ebx, 7
    je x_0_y_7


    add ecx, ebx
    mov [ecx + 8 * (eax + 1) + 1], byte 1
    mov [ecx + 8 * (eax + 1) - 1], byte 1
    jmp end

x_7:
    ; y ul e 0
    cmp ebx, 0
    je x_7_y_0
    ; y ul e 7
    cmp ebx, 7
    je x_7_y_7
    
    add ecx, ebx
    mov [ecx + 8 * (eax - 1) + 1], byte 1
    mov [ecx + 8 * (eax - 1) - 1], byte 1
    jmp end

x_0_y_0:
    ; caz special
    mov [ecx + 8 * (eax + 1) + 1], byte 1
    jmp end

x_0_y_7:
    ; caz special
    add ecx, ebx
    mov [ecx + 8 * (eax + 1) - 1], byte 1
    jmp end

x_7_y_0:
    ; caz special
    mov [ecx + 8 * (eax - 1) + 1], byte 1
    jmp end

x_7_y_7:
    ; caz special
    add ecx, ebx
    mov [ecx + 8 * (eax - 1) - 1], byte 1
    jmp end

y:
    ; verificam daca y ul e 0
    cmp ebx, 0
    je  y_0
    ; verificam daca y ul e 7
    cmp ebx, 7
    je  y_7

    jmp normal

y_0:
    ; caz special
    add ecx, ebx
    mov [ecx + 8 * (eax - 1) + 1], byte 1
    mov [ecx + 8 * (eax + 1) + 1], byte 1
    jmp end


y_7:
    ; caz special
    add ecx, ebx
    mov [ecx + 8 * (eax - 1) - 1], byte 1
    mov [ecx + 8 * (eax + 1) - 1], byte 1
    jmp end

normal:
    ; cazul normal
    add ecx, ebx
    mov [ecx + 8 * (eax - 1) + 1], byte 1
    mov [ecx + 8 * (eax + 1) + 1], byte 1
    mov [ecx + 8 * (eax - 1) - 1], byte 1
    mov [ecx + 8 * (eax + 1) - 1], byte 1
    jmp end

end:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY