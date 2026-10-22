%include "../include/io.mac"

    ;;
    ;;   TODO: Declare 'avg' struct to match its C counterpart
    ;;

struc avg
    .quo: resw 1
    .remain: resw 1
endstruc

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs
    extern printf

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    ; move address
    mov edx, [ebp + 8]
    ; move length
    mov ecx, [ebp + 12]

; iterate to all items
bucla:

    ; extract prio
    mov al, byte [edx + proc.prio]

    ; prio 1 => label prio 1
    cmp al, 1
    je  prio1

    ; prio 2 => label prio 2
    cmp al, 2
    je  prio2

    ; prio 3 => label prio 3
    cmp al, 3
    je  prio3

    ; prio 4 => label prio 4
    cmp al, 4
    je  prio4

    ; prio 5 => label prio 5
    cmp al, 5
    je prio5


prio1:
    ; add in global_vector_prio +1 for nr prio1
    add dword [prio_result + 4 * 0], 1
    ; add quantum time in global_vector_time
    mov si, [edx + proc.time]
    add word [time_result + 4 * 0], si
    ; go to next item
    jmp end

; same for prio2
prio2:
    add dword [prio_result + 4 * 1], 1 
    mov si, [edx + proc.time]
    add word [time_result + 4 * 1], si

    jmp end

; same for prio3
prio3:
    add dword [prio_result + 4 * 2], 1
    mov si, [edx + proc.time]
    add word [time_result + 4 * 2], si

    jmp end

; same for prio4
prio4:
    add dword [prio_result + 4 * 3], 1 
    mov si, [edx + proc.time]
    add word [time_result + 4 * 3], si

    jmp end

; same for prio5
prio5:
    add dword [prio_result + 4 * 4], 1
    mov si, [edx + proc.time]
    add word [time_result + 4 * 4], si

    jmp end
end:

    ; go to the next item
    add edx, 5

loop bucla

    ; clear register ecx (ecx = 0)
    xor ecx, ecx
     ; address proc_avg
    mov edi, [ebp + 16]

put_result:
    
    mov edx, 0
     ; dividend
    mov eax, dword [time_result + 4 * ecx]
     ; divisor
    mov ebx, dword [prio_result + 4 * ecx]

    ; if divisor = 0, complete with (0,0)
    cmp ebx, 0
    je basic

    ; make division
    div ebx


normal:
    ; put quo & remain
    mov [edi + avg.quo], ax
    mov [edi + avg.remain], dx
    jmp final

basic:
    ; set quo & remain (0,0)
    mov word [edi + avg.quo], 0
    mov word [edi + avg.remain], 0
    jmp final

final:

    ; go to the next element
    add edi, 4
    inc ecx
    cmp ecx, 5
    jne put_result

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY