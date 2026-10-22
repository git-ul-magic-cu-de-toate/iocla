; array de lungime len
section .data
    limit dd 120
    len equ   10

; declarare in .bss
section .bss
    int_arr: resd len

; initializare
    xor ecx, ecx
init_arr:
    mov eax, ecx ; initializare cu valoarea i
    mov [merged_temp + 4 * ecx], eax
    inc ecx
    cmp ecx, len
    jl init_arr

; afisare
xor ecx, ecx
print_arr:
    PRINTF32 `%d \x0`, dword[int_arr + 4 * ecx]
    inc ecx
    cmp ecx, len
    jl print_arr

; parcurgere
xor ecx, ecx
loop_arr:
    ;; operatii
    ;; --------
    inc ecx
    cmp ecx, len
    jl loop_arr

; numere mai mici strict decat o variabila globala
    xor edx, edx
    xor ecx, ecx
loop_arr:
    mov esi, [int_arr + 4 * ecx]
    cmp esi, [limit]
    jge not_smaller
    inc edx
not_smaller:
    inc ecx
    cmp ecx, len
    jl loop_arr

; gaseste element in arr sortat
    xor ecx, ecx
find_elem:
    mov esi, [int_arr + 4 * ecx]
    cmp esi, [limit]
    jg print_esi
    inc edx
    inc ecx
    cmp ecx, len
    jl find_elem
print_esi:
    PRINTF32 `%d\n\x0`, esi

; concateneaza 2 vectori
    xor ecx, ecx
init_arr_1:
    mov eax, [temp_1 + 4 * ecx] ; initializare cu valoarea i
    mov [merged_temp + 4 * ecx], eax
    inc ecx
    cmp ecx, len1
    jl init_arr_1

    xor ecx, ecx
init_arr_2:
    mov eax, [temp_2 + 4 * ecx] ; initializare cu valoarea i
    add ecx, len1
    mov [merged_temp + 4 * ecx], eax
    sub ecx, len1
    inc ecx
    cmp ecx, len2
    jl init_arr_2

; inverseaza un vector in-place
    xor ecx
    mov edx, len - 1
reverse:
    mov eax, [merged_temp + 4 * ecx]
    mov ebx, [merged_temp + 4 * edx]

    mov [merged_temp + 4 * ecx], ebx
    mov [merged_temp + 4 * edx], eax

    inc ecx
    dec edx

    cmp ecx, edx
    jl reverse