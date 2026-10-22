%include "printf32.asm"

section .data
    enc_val: dd 0xB6AC6583
    iv: dd 0xCAFEBABE
    key: dd 0xC00010FF
    enc_msg: dq 0xBC69AB8C1AEFD627
    len equ 2

section .bss
    dec_msg resq 1

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Decrypt the integer enc_val using the formula: (enc_val ^ key) - iv, 
    ;         and print it on single line in hexdecimal format.
    ;         Check to see if the result is odd or even, and acordignly print messages
    ;         on a single line for the two cases.

    mov eax, [enc_val]
    mov ebx, [key]

    xor eax, ebx

    mov ecx, [iv]

    sub eax, ecx

    PRINTF32 `0x%X\n\x0`, eax

    and eax, 1

    cmp eax, 0
    je even

    cmp eax, 0
    jne odd

even:
    PRINTF32 `even\n\x0`
    jmp end1

odd:
    PRINTF32 `odd\n\x0`
    jmp end1

end1:
 
    ; TODO b: Given an encrypted quad word enc_msg decrypt it, store it
    ;         dec_msg and print its value in hexadecimal format with leading zeros (ex: %08X) 
    ;         on sigle line 

    xor eax, eax
    mov eax, dword [enc_msg]
    mov ebx, dword [enc_msg + 4]

    mov ecx, [key]

    xor eax, ecx
    xor ebx, ecx

    mov edx, [iv]

    sub eax, edx
    sub ebx, edx

    mov dword[dec_msg], eax
    mov dword[dec_msg + 4], ebx

    PRINTF32 `0x%08X%X\n\x0`, dword[dec_msg], dword[dec_msg + 4]


; TODO c: Count the number of bits set to 0 in the dencrypted message dec_msg
    ;         (with a length of 8 bytes) and print it on single line 


    xor ecx, ecx
    xor edx, edx

    mov ebx, dword[dec_msg]

    mov eax, ebx
    and eax, 1
    cmp eax, 0
    je NOcount1

    cmp eax, 0
    jne count1

for1:
    mov eax, ebx
    shr eax, 1
    mov ebx, eax

    and eax, 1
    cmp eax, 0
    je NOcount1

    cmp eax, 0
    jne count1

count1:
    inc edx

NOcount1:

    inc ecx
    cmp ecx, 32
    jl for1

    mov ebx, dword[dec_msg + 4]
    xor ecx, ecx

    mov eax, ebx
    and eax, 1
    cmp eax, 0
    je NOcount2

    cmp eax, 0
    jne count2

for2:
    mov eax, ebx
    shr eax, 1
    mov ebx, eax

    and eax, 1
    cmp eax, 0
    je NOcount2

    cmp eax, 0
    jne count2

count2:
    inc edx

NOcount2:

    inc ecx
    cmp ecx, 32
    jl for2

    mov ebx, 64
    sub ebx, edx
    PRINTF32 `%d\n\x0`, edx



    leave
    ret
