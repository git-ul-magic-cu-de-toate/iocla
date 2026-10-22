%include "../include/io.mac"
section .data

section .text
    global bonus
    extern printf

bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

; verificam pentru x
x:
    cmp eax, 0
    je  x_0

    cmp eax, 7
    je  x_7

    cmp eax, 3
    jl  first_x

    cmp eax, 3
    je  x_3

    cmp eax, 4
    je  x_4

    cmp eax, 7
    jl  second_x
    
    jmp end

x_0:

    cmp ebx, 0
    je x_0_y_0

    cmp ebx, 7
    je x_0_y_7

; set position point
    mov edx, 1
    xor edi, edi
calculate_y_for_x_0:
    shl edx, 1
    inc edi
    cmp edi, ebx
    jne calculate_y_for_x_0

    jmp y_first

x_7:
    
    cmp ebx, 0
    je x_7_y_0

    cmp ebx, 7
    je x_7_y_7

; set position point
    mov edx, 1
    xor edi, edi
calculate_y_for_x_7:
    shl edx, 1
    inc edi
    cmp edi, ebx
    jne calculate_y_for_x_7

    shl edx, 24

    ; down left
    shr edx, 8
    shr edx, 1
    or [ecx], edx

    ; restore point
    shl edx, 1
    shl edx, 8

    ; down right
    shr edx, 8
    shl edx, 1
    or [ecx], edx
    
    jmp end

x_0_y_0:

; DIRECTION UP_RIGHT
; set point coordonates

;*********************
    mov edx, 1
;*********************
    
    ; direction up_right
    shl edx, 8
    shl edx, 1
    mov [ecx + 4], edx

    jmp end

x_0_y_7:

; DIRECTION UP_LEFT
; set point coordonates

;*******************************
    mov edx, 1
    
    xor edi, edi
execx0y7:    
    shl edx, 1
    inc edi
    cmp edi, ebx
    jne execx0y7

;*******************************

    ; direction up_left
    shl edx, 8
    shr edx, 1
    mov [ecx + 4], edx
    
    jmp end

x_7_y_0:

; DIRECTION DOWN_RIGHT
; set point coordonates
    
;******************************
    mov edx, 1
    shl edx, 24
;******************************

    ; direction down_right
    shr edx, 8
    shl edx, 1
    mov [ecx], edx

    jmp end

x_7_y_7:

; DIRECTION DOWN_LEFT
; set point coordonates

;*****************************
    mov edx, 1
    shl edx, 24

    xor edi, edi
execx7y7:
    shl edx, 1
    inc edi
    cmp edi, ebx
    jne execx7y7

    ; direction down_left
    shr edx, 8
    shr edx, 1
    mov [ecx], edx
    
    jmp end


first_x:

; set point coordonates

;****************************
    mov edx, 1

    xor edi, edi
row_first_x:
    shl edx, 8
    inc edi
    cmp edi, eax
    jne row_first_x

    ; check for y
    cmp ebx, 0
    je y0_first

    xor edi, edi
column_first_x:
    shl edx, 1
    inc edi
    cmp edi, ebx
    jne column_first_x
;****************************

    cmp ebx, 7
    je y7_first

    jmp y_first

    jmp end 

second_x:

; set point coordonates

;****************************
    mov edx, 1

    xor edi, edi
    add edi, 4
row_second_x:
    shl edx, 8
    inc edi
    cmp edi, eax
    jne row_second_x

; check for y

    cmp ebx, 0
    je y0_second
    
    xor edi, edi
column_second_x:
    shl edx, 1
    inc edi
    cmp edi, ebx
    jne column_second_x
;****************************

    cmp ebx, 7
    je y7_second

    jmp y_second
    
    jmp end 

y_first:

    ; set all directions

    ; UP left
    shl edx, 8
    shr edx, 1
    or [ecx + 4], edx

    ; back to point
    shl edx, 1
    shr edx, 8

    ; UP right
    shl edx, 8
    shl edx, 1
    or [ecx + 4], edx

    ; back to point
    shr edx, 1
    shr edx, 8

    ; DOWN left
    shr edx, 8
    shr edx, 1
    or [ecx + 4], edx

    ; back to point
    shl edx, 1
    shl edx, 8

    ; DOWN right
    shr edx, 8
    shl edx, 1
    or [ecx + 4], edx

    jmp end

y_second:
    ; set all directions

    ; UP left
    shl edx, 8
    shr edx, 1
    or [ecx], edx

    ; back to point
    shl edx, 1
    shr edx, 8

    ; UP right
    shl edx, 8
    shl edx, 1
    or [ecx], edx

    ; back to point
    shr edx, 1
    shr edx, 8

    ; DOWN left
    shr edx, 8
    shr edx, 1
    or [ecx], edx

    ; back to point
    shl edx, 1
    shl edx, 8

    ; DOWN right
    shr edx, 8
    shl edx, 1
    or [ecx], edx

    jmp end

y0_first:
    
    ; set all directions

    ; UP right
    shl edx, 8
    shl edx, 1
    or [ecx + 4], edx

    ; back to point
    shr edx, 1
    shr edx, 8

    ; DOWN right
    shr edx, 8
    shl edx, 1
    or [ecx + 4], edx

    jmp end


y7_first:    

    ; set all directions

    ; UP left
    shl edx, 8
    shr edx, 1
    or [ecx + 4], edx

    ; back to point
    shl edx, 1
    shr edx, 8

    ; DOWN left
    shr edx, 8
    shr edx, 1
    or [ecx + 4], edx

    jmp end

y0_second:
    
    ; set all directions

    ; UP right
    shl edx, 8
    shl edx, 1
    or [ecx], edx

    ; back to point
    shr edx, 1
    shr edx, 8

    ; DOWN right
    shr edx, 8
    shl edx, 1
    or [ecx], edx

    jmp end


y7_second:

    ; set all directions

    ; UP left
    shl edx, 8
    shr edx, 1
    or [ecx], edx

    ; back to point
    shl edx, 1
    shr edx, 8

    ; DOWN left
    shr edx, 8
    shr edx, 1
    or [ecx], edx


    jmp end

x_3:

; set points coord
    mov edx, 1

    xor edi, edi
column_for_x3:
    shl edx, 1
    inc edi
    cmp edi, ebx
    jne column_for_x3

    shl edx, 24


    ; down LEFT
    shr edx, 8
    shr edx, 1
    or [ecx + 4], edx
    
    ; reset point
    shl edx, 1
    shl edx, 8

    ; down RIGHT
    shr edx, 8
    shl edx, 1
    or [ecx + 4], edx

; next int
    mov edx, 1
    
    xor edi, edi
column_for_x3_1:
    shl edx, 1
    inc edi
    cmp edi, ebx
    jne column_for_x3_1

    shl edx, 1
    or [ecx], edx

    shr edx, 1
    
    shr edx, 1
    or [ecx], edx

    jmp end

x_4:
    ; set points coord
    mov edx, 1

    xor edi, edi
column_for_x4:
    shl edx, 1
    inc edi
    cmp edi, ebx
    jne column_for_x4

    shl edx, 8

    shl edx, 1
    or [ecx], edx

    shr edx, 1
    shr edx, 1
    or [ecx], edx

; next int
    mov edx, 1
    
    xor edi, edi
column_for_x4_1:
    shl edx, 1
    inc edi
    cmp edi, ebx
    jne column_for_x4_1

    shl edx, 24

    shl edx, 1
    or [ecx + 4], edx

    shr edx, 1
    shr edx, 1
    or [ecx + 4], edx

    jmp end

end:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY