section .data
    ; " .,\n\0"
    delimiters db ' ,.', 10, 0

section .text
global sort
global get_words
extern strtok
extern qsort
extern strlen
extern strcmp

compare:
    ; create a new stack frame
    enter 0, 0

    push esi
    push edi
    push ebx

    ; s1 = *(char**)a
    ; esi = s1
    mov eax, [ebp + 8]
    mov esi, [eax]

    ; s2 = *(char**)b
    ; edi = s2
    mov eax, [ebp + 12]
    mov edi, [eax]

    ; strlen(s1)
    push ecx
    push edx

    ; ebx = len1
    push esi
    call strlen
    ; clean up stack
    add esp, 4
    mov ebx, eax

    pop edx
    pop ecx

    ; strlen(s2)
    push eax
    push edx

    ; ecx = len2
    push edi
    call strlen
    ; clean up stack
    add esp, 4
    mov ecx, eax

    pop edx
    pop eax

    ; if (len1 - len2 != 0)
    cmp ebx, ecx
    je .equal_len

    ; return len1 - len2
    mov eax, ebx
    sub eax, ecx
    jmp .done

.equal_len:
    ; strcmp(s1, s2)
    push ecx
    push edx

    push edi
    push esi
    call strcmp
    ; clean up stack
    add esp, 8

    pop edx
    pop ecx
    ; eax contains final result

.done:
    pop ebx
    pop edi
    pop esi

    leave
    ret

;; sort(char **words, int number_of_words, int size)
sort:
    ; create a new stack frame
    enter 0, 0

    ; compare function
    push compare
    ; size
    push dword [ebp + 16]
    ; number_of_words
    push dword [ebp + 12]
    ; words
    push dword [ebp + 8]
    call qsort
    ; clean up stack
    add  esp, 16

    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
get_words:
    ; create a new stack frame
    enter 0, 0
    push ebx
    push esi
    push edi

    ; s
    mov ebx, [ebp + 8]
    ; words
    mov edi, [ebp + 12]
    ; number_of_words
    mov ecx, [ebp + 16]

    ; count = 0
    xor esi, esi

    ; prepare 1st strtok call
    ; eax = strtok(s, delimiters)
    push ecx
    push edx

    push delimiters
    push ebx
    call strtok
    ; clean the stack
    add esp, 8

    pop edx
    pop ecx

start_loop:
    ; while (count >= number_of_words)
    cmp esi, ecx
    jge end_loop

    ; words[count++] = eax;
    ; offset = count * 4 (sizeof_ptr);
    ; words[offset] = eax;
    ; count++;
    imul edx, esi, 4
    mov [edi + edx], eax
    inc esi

    ; eax = strtok(NULL, delimiters);
    push ecx
    push edx

    push delimiters
    ; push NULL
    push 0
    call strtok
    ; clean up stack
    add esp, 8

    pop edx
    pop ecx

    jmp start_loop

end_loop:
    pop edi
    pop esi
    pop ebx

    leave
    ret
