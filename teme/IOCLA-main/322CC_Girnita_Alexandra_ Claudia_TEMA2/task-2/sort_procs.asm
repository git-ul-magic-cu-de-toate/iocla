%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs
    extern printf

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
    
    ; clear register eax & ebx
    xor eax, eax
    xor ebx, ebx
        
; while (we need to sort)
do:

    ; clear register esi (flag = 0)
    xor esi, esi
    
    ; restore vector address
    mov edx, [ebp + 8]
    ; restore vector length
    mov ecx, [ebp + 12]
    ; (length - 1) (compare item [k] with [k + 1])
    dec ecx

; sort elements in a for
bucla:

; sort by prio
prio:

    ; use AL, BL to store [k], [k + 1]
    mov al, byte [edx + proc.prio]
    mov bl, byte [edx + 5 + proc.prio]
    ; compare them
    cmp al, bl
    ; equal => go to time
    je time
    ; if first > second => switch
    jg switch
    ; go to next iteration
    jmp end
    
; sort by time
time:

    ; use AX, BX to store [k], [k + 1]
    mov ax, word [edx + proc.time]
    mov bx, word [edx + 5 + proc.time]
    ; compare them
    cmp ax, bx
    ; equal => go to pid
    je pid
    ; if first > second => switch
    jg switch
    ; go to next iteration
    jmp end

; sort by pid
pid:

    ; use AX, BX to store [k], [k + 1]
    mov ax, word [edx + proc.pid]
    mov bx, word [edx + 5 + proc.pid]
    ; compare them
    cmp ax, bx
    ; if first > second => switch
    jg switch
    ; go to next iteration
    jmp end

; switch elements
switch:

    ; mov pid
    mov ax, word [edx + proc.pid]
    mov bx, word [edx + 5 + proc.pid]

    mov word [edx + proc.pid], bx
    mov word [edx + 5 + proc.pid], ax

    ; mov prio
    mov al, byte [edx + proc.prio]
    mov bl, byte [edx + 5 + proc.prio]

    mov byte [edx + proc.prio], bl
    mov byte [edx + 5 + proc.prio], al

    ; mov time
    mov ax, word [edx + proc.time]
    mov bx, word [edx + 5 + proc.time]

    mov word [edx + proc.time], bx
    mov word [edx + 5 + proc.time], ax

    ; mark flag (flag = 1)
    mov esi, 1

end:

    ; go to next item
    add edx, 5

loop bucla

    ; if flag = 1, sort again
    cmp esi, 1
    je  do

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY