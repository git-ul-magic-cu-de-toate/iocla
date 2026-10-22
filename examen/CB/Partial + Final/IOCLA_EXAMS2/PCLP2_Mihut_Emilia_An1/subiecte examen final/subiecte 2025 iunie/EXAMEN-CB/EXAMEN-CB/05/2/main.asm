section .rodata
rostring db "This is a string with many a's!", 0
N equ 64
KEY_LENGTH equ 16
fmt_str db '%s', 13, 10, 0
fmt_dec db '%d', 13, 10, 0
old_str db 'ahi', 0

section .text
global main

replace_chars:
    ; TODO b: Implement `void replace_chars(char *string, char new, char *old)`
    ; which, for each character in `old`, replaces each of its occurrences in `string` with `new`.
    ; Example: replace("abcdcba", 'e', "bc") will modify the string so that it becomes "aeedeea".
    
count_words:
    ; TODO c: Implement `int count_words(char *string)` 
    ; to count the number of words in `string`. The words will be separated by a single space.

random_key:
    ; TODO d: Implement `char *random_key(int length)`
    ; which creates a new string on the heap of exactly `length + 1` bytes that stores a
    ; random string of lowercase letters. Return the new string.

main:
    push ebp
    mov ebp, esp
    
    ; TODO a: Create a string of N bytes on the stack.
    
    ; TODO a: Use strcpy to copy the contents of rostring into the new string.
    
    ; TODO a: Print the new string.
    
    ; TODO b: Call `replace_chars` on the string created at TODO a to replace each occurrence of the characters `a`, `h` and `i` with `b`.
    ; You may use `old_str`, defined in `.rodata`!
    
    ; TODO b: Print the string on the stack.
    
    ; TODO c: Print the number of words in `rostring` by calling `count_words`.
    
    ; TODO d: Create a random string of length `KEY_LENGTH` using `random_key`.
    
    ; TODO d: Print the random string. 
    
    leave
    ret
