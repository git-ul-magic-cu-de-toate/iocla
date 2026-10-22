extern puts
extern printf


section .rodata
    format db "%u ", 0
    newline db  10, 0
    puts_format db "", 0


section .data
    arr1 dd 10, 20, 30, 40, 50, 60, 70, 80
    len1 equ 8
    arr2 dd 11, 22, 33, 44, 55, 66, 77, 88, 99
    len2 equ 9


section .bss
    dest resd 10


section .text
global main


sum_adj:
    push ebp
    mov ebp, esp

    ; TODO b: Implement adjacent sum computing function:
    ; sum_adj(unsigned int *a, unsigned int *dest, unsigned int len);

    leave
    ret


sum_inplace:
    push ebp
    mov ebp, esp

    ; TODO c: Implement inplace sum computing function:
    ; sum_inplace(unsigned int *a, unsigned int len);

    leave
    ret


print_arr:
    push ebp
    mov ebp, esp

    ; TODO a: Implement array printing function:
    ; print_arr(unsigned int *arr, unsigned int len);

    mov eax, [ebp+8]
    mov ebx, [ebp+12]
    mov ecx, 0

for_loop:
    cmp ecx, ebx
    jge end

    push eax
    push ecx

    push dword[eax + 4*ecx]
    push format
    call printf
    add esp, 8

    pop ecx
    pop eax

    inc ecx
    jmp for_loop

end:

    push newline
    call printf
    add esp, 4

    leave
    ret


main:
    push ebp
    mov ebp, esp


    ; Print arr1 using print_arr.
    push dword len1
    push arr1
    call print_arr
    add esp, 8

    ; Compute sum in dest using sum_adj.
    push dword len1
    push dest
    push arr1
    call sum_adj
    add esp, 12

    ; Print dest using print_arr.
    push dword len1
    push dest
    call print_arr
    add esp, 8

    ; Compute sum inplace in arr1.
    push dword len1
    push arr1
    call sum_inplace
    add esp, 8

    ; Print arr1 using print_arr.
    push dword len1
    push arr1
    call print_arr
    add esp, 8


    ; Return 0.
    xor eax, eax
    leave
    ret
