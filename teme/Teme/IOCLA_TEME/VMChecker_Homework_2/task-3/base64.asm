%include "../include/io.mac"

extern printf
global base64

section .data
	alphabet db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
	fmt db "%d", 10, 0

section .text

base64:
	;; DO NOT MODIFY

    push ebp
    mov ebp, esp
	pusha

	mov esi, [ebp + 8] ; source array
	mov ebx, [ebp + 12] ; n
	mov edi, [ebp + 16] ; dest array
	mov edx, [ebp + 20] ; pointer to dest length

	;; DO NOT MODIFY


	; -- Your code starts here --

    xor edx, edx                ; clear edx ptr; will be loaded later
	mov edx, ebx                ; edx: loop cnt
								; eax: continually add 1 byte in ah
                                ; then do multiple shifting of eax
                                ; so that ah stores the offset for alphabet
                                ; ecx: full register to store alphabet offset
                                ; ebx: will store the value at said offset
loop_begin:
    cmp edx, 0
    je  loop_end

    xor ecx, ecx                ; clear ecx register
    xor eax, eax                ; clear eax register
    mov ah, byte [esi]          ; load 1st byte from source array

    shr eax, 2                  ; shift right so I have first 6 bits in ah
    mov cl, ah
    mov ebx, [alphabet + ecx]
    mov [edi], ebx              ; load 1st char in dest array

    xor ah, ah                  ; clear ah
    shl eax, 10                 ; move the 2 bits left in al to just before ah
    mov ah, byte [esi + 1]      ; load 2nd byte from source array

    shr eax, 4                  ; shift right so I have next 6 bits in ah
    mov cl, ah
    mov ebx, [alphabet + ecx]
    mov [edi + 1], ebx          ; load 2nd char in dest array

    xor ah, ah                  ; clear ah
    shl eax, 12                 ; move the 4 bits left in al to just before ah
    mov ah, byte [esi + 2]      ; load 3rd byte from source array

    shr eax, 6                  ; shift right so I have next 6 bits in ah
    mov cl, ah
    mov ebx, [alphabet + ecx]
    mov [edi + 2], ebx          ; load 3rd char in dest array

    xor ah, ah                  ; clear ah
    shl eax, 6                  ; move the 6 bits left in al to ah

    mov cl, ah
    mov ebx, [alphabet + ecx]
    mov [edi + 3], ebx          ; load 4th char in dest array

	add esi, 3 	                ; advance in source array
    add edi, 4                  ; advance in dest array
    sub edx, 3                  ; advance in counter
    jmp loop_begin

loop_end:
                                ; perform calculation: n * 8 / 6
                                ; to get no of elements in dest array
    mov eax, [ebp + 12]         ; load n into eax
    xor edx, edx                ; clear edx
    mov ebx, 8                  ; ebx = 8
    mul ebx                     ; eax = eax * ebx

    xor edx, edx                ; clear edx
    mov ebx, 6                  ; ebx = 6
    div ebx                     ; eax = eax / ebx

    mov edx, [ebp + 20]         ; let edx point to dest array len again
    mov [edx], eax              ; update dest array len

	; -- Your code ends here --


	;; DO NOT MODIFY

	popa
	leave
	ret

	;; DO NOT MODIFY