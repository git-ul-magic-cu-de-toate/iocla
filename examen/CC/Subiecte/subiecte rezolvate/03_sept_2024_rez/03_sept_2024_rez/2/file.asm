extern printf


section .data
    ushex_format_newline    db "before: 0x%04hx, after: 0x%04hx", 10, 0
    uihex_format_newline    db "before: 0x%08x, after: 0x%08x", 10, 0
    ullhex_format_newline    db "before: 0x%016llx, after: 0x%016llx", 10, 0

    sample_ushort   dw 0x0102
    sample_uint  dd 0x01020304
    sample_ullong dq 0x0102030405060708

section .text
global main


ntohs:
    push ebp
    mov ebp, esp

    ; TODO b: Implement ntohs() functionality.

    mov ax, word [ebp + 8]
    mov edx, [ebp + 12]

    xor ebx, ebx

    mov bl, al

    shr ax, 8
    shl ebx, 8
    xor ecx, ecx
    mov cl, al
    add ebx, ecx
    
    mov eax, ebx

    leave
    ret


ntohi:
    push ebp
    mov ebp, esp

    ; TODO a: Implement ntohi() functionality.
    mov eax, [ebp + 8]         ; sample_unit    0x -1 -2 -3 -4          ----->       0x  -4 -3 -2 -1
                                ;                        al  bl                          bl cl
                                ;                   -- bl al --
    xor ebx, ebx

    mov bl, al

    shr eax, 8
    shl ebx, 8
    xor ecx, ecx
    mov cl, al
    add ebx, ecx

    shl ebx, 8
    shr eax, 8
    xor ecx, ecx
    mov cl, al
    add ebx, ecx

    shl ebx, 8
    shr eax, 8
    xor ecx, ecx
    mov cl, al
    add ebx, ecx

    mov eax, ebx    

    leave
    ret


ntohll:
    push ebp
    mov ebp, esp

    ; TODO c: Implement ntohll() functionality.
    mov edx, [ebp + 8]         ; adresa vector
    mov eax, dword [edx]

    xor ebx, ebx

    mov bl, al

    shr eax, 8
    shl ebx, 8
    xor ecx, ecx
    mov cl, al
    add ebx, ecx

    shl ebx, 8
    shr eax, 8
    xor ecx, ecx
    mov cl, al
    add ebx, ecx

    shl ebx, 8
    shr eax, 8
    xor ecx, ecx
    mov cl, al
    add ebx, ecx

    mov esi, ebx        ; --> primi cei mai la stanga 8 octeti

    mov eax, dword [edx + 4]

    xor ebx, ebx

    mov bl, al

    shr eax, 8
    shl ebx, 8
    xor ecx, ecx
    mov cl, al
    add ebx, ecx

    shl ebx, 8
    shr eax, 8
    xor ecx, ecx
    mov cl, al
    add ebx, ecx

    shl ebx, 8
    shr eax, 8
    xor ecx, ecx
    mov cl, al
    add ebx, ecx

    mov edi, ebx  ; cei mai la dreapta 8 octeti

    mov dword [edx], esi
    mov dword [edx + 4], edi

    mov eax, edx

    leave
    ret


main:
    push ebp
    mov ebp, esp


    push word 0
    push word [sample_ushort]
    call ntohs
    add esp, 4

    ; TODO b: Print before and after ntohs().


    push eax
    push dword [sample_ushort]
    push ushex_format_newline
    call printf
    add esp, 12


    ; TODO a: Call ntohi().

    push dword [sample_uint]
    call ntohi
    add esp, 4

    push eax
    push dword [sample_uint]
    push uihex_format_newline
    call printf
    add esp, 12


    ; TODO c: Call ntohll() and print before and after().

    push sample_ullong
    call ntohll
    add esp, 4

    push dword [eax + 4]
    push dword [eax]
    push dword [sample_ullong]
    push dword [sample_ullong]
    push ullhex_format_newline
    call printf
    add esp, 16



    ; Return 0.
    xor eax, eax
    leave
    ret
