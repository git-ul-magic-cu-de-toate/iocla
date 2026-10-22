section .data
    before_format db "before %s", 13, 10, 0
    after_format db "after %s", 13, 10, 0
    mystring db "abcdefghij", 0
    rot13_format db "rot13 %s", 13, 10, 0

section .text

extern printf
global main


;;;;;;;;;;;; transf din litere mici in litere mari ;;;;;;;;;
toupper:
    push ebp
    mov ebp, esp

    mov eax, dword [ebp + 8]
check_letter:
    mov bl, byte [eax]
    cmp bl, 0
    je finish

    cmp bl, 'a'
    jl skip_letter
    cmp bl, 'z'
    jg skip_letter

    sub bl, 32
    mov byte [eax], bl
skip_letter:
    inc eax
    jmp check_letter

finish:
    leave
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;; rot 13 ;;;;;;;;
rot13:
    push ebp
    mov ebp, esp 
    mov eax, dword [ebp + 8]
iterate:
    mov bl, byte [eax]
    cmp bl, 0
    je end

    cmp bl, 'n'
    jge substitution
    cmp bl, 'a'
    jge addition
    cmp bl, 'N'
    jge substitution
addition:
    add bl, 13
    jmp continue
substitution:
    sub bl, 13

continue:
    mov byte [eax], bl
    inc eax
    jmp iterate
end:
    leave
    ret
;;;;;;;;;;;;;;;;;;;;;;;

main:
    push ebp
    mov ebp, esp

    push mystring
    push before_format
    call printf
    add esp, 8

    push mystring
    call toupper
    add esp, 4

    push mystring
    push after_format
    call printf
    add esp, 8

    ;;; rot13 ;;;
    push mystring
    call rot13
    add esp, 4

    push mystring
    push rot13_format
    call printf
    add esp, 8
    ;;;;;;;;;;;;

    leave
    ret
