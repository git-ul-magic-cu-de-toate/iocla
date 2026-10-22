%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here
    
    ; clear register eax (eax = 0)
    xor    eax, eax         

; repeat len times (ecx = len)
bucla:                      

    ; extract letter
    mov    al, [esi]
    ; add step
    add    al, dl
    ; letter <= Z
    cmp    al, 91
    jl     ok

; make a reset
reset:  
    sub    al, 26


ok:
    ; put in enc_string
    mov    [edi], al
    ; go next plain letter
    add    esi, 1
    ; go next encoded letter           
    add    edi, 1

loop bucla

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY