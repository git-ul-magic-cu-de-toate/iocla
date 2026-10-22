extern strlen
extern printf
extern malloc
extern getchar

section .data

str1 db 'Would somebody get this big walking carpet out of my way?', 0
str_fmt db '%s', 10, 0
int_fmt db '%d', 10, 0

N equ 100
section .bss

str2 resb N

section .text
global main

; TODO b: Implementati functia void foo_gets(char *str, int size) cu urmatorul comportament:
    ;       - citeste cel mult `size-1` caractere de la intrarea standard si le stocheaza in memorie
    ;         la adresa `str`.
    ;       - citirea se opreste la intalnirea EndOfFile sau la intalnirea caracterului `newline`
    ;       - terminatorul de sir `0` se va stoca dupa ultimul caracter din sirul `str`
    ;       - folositi functia cu antetul in C `int getchar()` pentru a citi un caracter de la intrarea standard:
    ;           - getchar() intoarce urmatorul caracter din intrarea standard conertit la int
    ;           - getchar() intoarce 0 atunci cand se ajunge la EndOfFile
    ;           - getchar() intoarce 10 (decimal) atunci cand se citeste caracterul `newline`
    ;	ATENTIE: nu aveti voie  sa folositi apelul `fgets`.
foo_gets:
	push ebp
	mov ebp, esp


	leave
	ret

;TODO c: Implementati functia `int find_last_pos(char *str, char c)` care intoarce
    ;       indexul ultimei aparitii a caracterului primit in argumentul `c` din sirul
    ;       de caractere primit in argumentul `str`.
    ;       Functia intoarce -1 daca `c` nu se gaseste in `str`.
    ;
find_last_pos:
    push ebp
    mov ebp, esp


    leave
    ret

; TODO d: Implementati functia `int count_apps(char *str, char c, int l, int r)
    ;       care numara de cate ori apare caracterul dat de argumentul `c` in sirul `str`
    ;       intre pozitiile `l` si `r` (inclusiv).
    ;       Este garantat ca 0 <= l <= r < strlen(str)

count_apps:
    push ebp
    mov ebp, esp
    push esi
    push edi


    leave
    ret

main:
    push ebp
    mov ebp, esp

;TODO a; Afisati la iesirea standard sirul `input_str` precum si lungimea acestuia. Fiecare afisare se va face pe o linie noua.
    ; Folositi functia de biblioteca `strlen` pentru a determina lungimea unui sir de caractere.
    ; Folositi functia `printf` pentru afisare


;TODO b: Apelati functia `foo_gets` pentru a citi de la intrarea standard un sir de maxim `N-1`
 ;           caractere pe care-l veti stoca la adresa `str2`. Afisati apoi `str2`.



; TODO c: Functia `find_last_pos` este deja apelata mai jos
    ;   Afisati rezultatul folosind functia de biblioteca `printf`


;TODO d: Functia `count_apps` este deja apelata mai jos.
    ;   Afisati rezultatul folosind functia de biblitoca `printf`


    ; Return 0.
    xor eax, eax
    leave
    ret
