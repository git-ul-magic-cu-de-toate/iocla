section .data
    map_size: dd 27
    sir: db "we all love iocla.", 0
    fmt_letter: db "%c: %d", 10, 0 

section .bss
    map: resb 27

section .text
global main
extern printf

; TODO a: Implement `void insert_in_map(char *map, int *size, char *str)`
; which inserts letters and their occurrences found in the string `str` into `map`.

insert_in_map:
    push ebp
    mov ebp, esp
    
    ; Get parameters
    mov edi, [ebp + 8]      ; map
    mov esi, [ebp + 16]     ; str
    
process_letter:
    ; Load current character
    movzx eax, byte [esi]   
    test al, al            ; Check if we reached end of string
    jz done_insert
    
    inc byte [edi + eax]   ; Increment count for current letter
    
    inc esi                ; Move to next character
    jmp process_letter

done_insert:
    leave
    ret


; TODO b: Implement `void print_map(char *map, int *size)`
; which displays, for each key in `map` of maximum size `size`,
; its value—that is, for each letter with a non-zero count,
; print "<Letter>: <count>\n".

print_map:
    push ebp
    mov ebp, esp
    push ebx                ; Save registers we'll use
    
    mov edi, [ebp + 8]      ; map
    mov ecx, [ebp + 12]     ; size
    xor ebx, ebx            ; Counter for current character

print_loop:
    cmp ebx, [ebp + 12]     ; Compare with size
    jge print_done
    
    movzx eax, byte [edi + ebx]  ; Get count for current letter
    test al, al                  ; Check if count is zero
    jz skip_print
    
    ; Print if count > 0
    push eax                     ; Count
    push ebx                     ; Letter
    push fmt_letter
    call printf
    add esp, 12
    
skip_print:
    inc ebx
    jmp print_loop

print_done:
    pop ebx
    leave
    ret


; TODO c: Implement `void card_map(char *map, int *size)`
; which displays the number of the <key, value> stored in the `map` of maximum size `size` bytes.

card_map:
    push ebp
    mov ebp, esp

    leave
    ret


; TODO d: Implement `void expand_map(char *map, int *size)`
; which traverses the entire `map` of maximum size `size`,
; and for each key updates its associated value using the formula:
; ((2 * value + 1) << 7) % 5.

expand_map:
    push ebp
    mov ebp, esp

    
    leave
    ret


main:
    push ebp
    mov ebp, esp

    ; TODO a: Call `insert_in_map` using `map`, `size`, and the string in `.data`
    ; that counts letter occurrences and stores them in `map`.
    ; NOTE: Display the letter with the highest occurrence and its count at the end.

    push sir
    push map_size
    push map
    call insert_in_map
    add esp, 12
    ; TODO b: Call `print_map` using `map` and `size`
    ; which prints each letter in the map with a non-zero count.
    ; NOTE: Allocate the string "It's not that hard." on the stack,
    ; call `insert_in_map` for this string first, then print the map.
    push map_size
    push map
    call print_map
    add esp, 8

    ; TODO c: Call `card_map` using `map` and `size`
    ; which displays the cardinality (number of unique letters) of the map.
    ; NOTE: Use the map populated by previous calls.


    ; TODO d: Call `expand_map` using `map` and `size`
    ; which updates each value with ((2 * value + 1) << 7) % 5 formula.
    ; call `print_map` to display the updated map.


    xor eax, eax
    leave
    ret
