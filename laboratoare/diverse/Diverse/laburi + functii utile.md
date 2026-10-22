## lab 1 - reprezentare-numere
- **operatii pe biti + pointeri**

## lab 2 - operatii-memorie-gdb 
- **comenzi utile gdb**
- void *
- **dimensiuni date**
- **padding structuri**
- **packed**

## lab 3 - etapele-compilarii 
- **exemple makefile in exercitii cu linkare** 
- utilitare: linkare **ld** + argumente in linia comanda, **nm**, **readelf** 
- **_start()**
```
	gcc -c -o app.o app.c => fisier obiect
	gcc -o app app.o => linkare fisier obiect si creare executabil
```

> Dacă avem mai multe fișiere sursă C, invocăm compilatorul pentru fiecare fișier și apoi linker-ul:

```
	gcc -c -o helpers.o helpers.c
	gcc -c -o app.o app.c
	gcc -o app app.o helpers.o
```

> Ultima comandă este comanda de linking, care leagă fișierele obiect app.o și helpers.o în fișierul executabil app.

> `gcc -L<directory>` => adauga directoare in care cauta biblioteci (lib) la linkare

## lab 4 - toolchain-decompilare 
-	godbolt -> flaguri
- **ghidra**

## lab 5 - introducere-assembly 
- instructiuni: xchg, not
- fibonacci

	> **PRINTF32:**
```
	%include "printf32.asm" / %include "../utils/printf32.asm"  ; din directorul cu laboratoarele

	section .data
		myString: db "Hello, World!", 0

	section .text
    	global main
    	extern printf

	main:
    	PRINTF32 `%d\n\x0`, eax
		PRINTF32 `%s\n\x0`, myString
```

## lab 6 - rolul-registrelor 
- **declarare variabile** 
- **adresarea memoriei** 
- **inmultirea a doua numere** 
- **impartirea a doua numere** 
- puteri ale lui 2

```
	section .data
		var2       DB ?     ; Declară un octet neinițializat etichetat cu "var2".
```
## lab 7 - structuri-vectori-siruri
- **structuri**
- **vectori**
- **vectori de structuri**
- **fibonacci** (implementat de tine)
- **implementare strcpy** (ex 4 implementat de tine)
- **implementare strstr** (solutii ex 5)

> ***Structuri:***

```
	struc mystruct
    	a:    resw 1    ; a va referi un singur element de dimensiune un cuvânt
    	b:    resd 1    ; b va referi un singur element de dimensiune un dublu cuvânt
		c:    resb 1    ; c va referi un singur element de dimensiune un octet
  		d:    resd 1    ; d va referi un singur element de dimensiune un dublu cuvânt
   		e:    resb 6    ; e va referi 6 elemente de dimensiune un octet
	endstruc
```
	
> ca sa folosesti aceleasi campuri pentru mai multe structuri:

```
	struc mystruct1
   		.a:    resw 1
   		.b:    resd 1
	endstruc

	struc mystruct2
   		.a:    resd 16
   		.b:    resw 1
	endstruc
```

> initializare:

	struct_var:           				; asta e numele variabilei (adresa de unde incepe structura)
    	istruc mystruct    			; aici ai numele structuri       
    		at a, dw        -1
    		at b, dd        0x12345678
       		at c, db        ' '
       		at d, dd        23
       		at e, db        'Gary', 0
   		iend
	
> În cazul în care definiți câmpurile structurii folosind . (dot), instanțierea structurii se face în felul următor:

```
	struct_var:
    	istruc mystruct
        	at mystruct.a, dw        -1
        	at mystruct.b, dd        0x12345678
        	at mystruct.c, db        ' '
        	at mystruct.d, dd        23
        	at mystruct.e, db        'Gary', 0
   		iend
```

> Accesarea campurilor difera daca declari cu . sau fara!!!!

> ***Vectori:***

> De exemplu, pentru a declara un vector de 100 de cuvinte inițializate cu valoarea 42, vom folosi construcția:
```Assembly
section .data
    myVect:    times 100    dw 42
```
> Pe de altă parte, dacă dorim declararea unui vector de 20 de elemente dublu cuvinte neinițializate, folosim instrucțiuni din familia ``res`` astfel:
```Assembly
section .bss
    myVect:    resd 20
```

## lab 8 - stiva 
- **afisare cu numar exact de zecimale (ex 0)**
- **media aritmetica (ex 0)**
- **cmmdc (ex 5)**
- **interclasare (ex 4 merge arrays)**

## lab 9 - apel-functii
- fibonacci doar cu stiva
- **flaguri gcc => cod assembly (ex 2)**
- **objdumb** 
- **strlen (ex 4)**
- **strrev/reverse string (ex 5)** 
- **transformare litere mici in litere mari - toupper (ex 6)**

`gcc -m32 -masm=intel -S -o test.asm test.c`

`objdump -M intel -d test.o`

## lab 10 - interactiune-c-assembly

assembly -> C: **global** nume_functie

			   nume_functie:
				    instructiuni

			    folosit des: global main

C -> assembly: **extern** functii_din_c_folosite_in_asm

## lab 11 - buffer-overflow
- **variabile locale pe stiva (ex 2, facut de tine)**
- **payloads**
- **citire de la stdin, fget, gets**
- **afisare stringuri caracter cu caracter (ex 7)**

`python3 -c 'print("A"*64 + "FLOW")' > payload`

sau: (cu codul ASCII in hexa, tot in aceeasi ordine)

`python3 -c 'print("A"*64 + "\x46\x4C\x4F\x57")' > payload`

`./executabil < payload`

va suprascrie adresa ceruta cu 0x574F4C46

> **fgets**:

```
	lea ebx, [ebp-68]
    push dword [stdin]
    push 72
    push ebx
    call fgets
    add esp, 12
```

> Buffer overflow in C: compilare, obtinere cod in assembly, buffer overflow pe baza adreselor din codul in assembly 

### pregatire examen

## CA Var 1 + CD 2024
- **scanf** si **printf** pt vectori (ex 2)
- **pow** (ex 2) !!! e gresit pt N = 0
- **map** (ex 2)

## CB Var 1 2023
- **strcmp** (ex 2 b)
- **is_number** (ex 2 d) verifica daca un string a numar, format doar din cifre

my_strcmp:
    push ebp
    mov ebp, esp

    mov edx, [ebp + 8]
    mov ebx, [ebp + 12]

    xor esi, esi

loop3:
    mov al, byte [edx + esi] 
    mov cl, byte [ebx + esi]

    cmp al, 0
    je test_ebx

    cmp cl, 0
    je greater

    cmp al, cl 
    jg greater
    jl lower

    inc esi
    jmp loop3

test_ebx:
    cmp cl, 0
    je equal
    jmp lower

greater:
    mov eax, 1
    jmp end_strcmp

lower:
    mov eax, -1
    jmp end_strcmp

equal:
    xor eax, eax

end_strcmp:
    leave
    ret


**FIBONACCI RECURSIV:**
fibo:
push ebp
mov ebp, esp    
    mov ecx, [ebp + 8] ; n
    xor eax, eax ; facem valoarea de return 0
   dec eax ; -1 momentan
    ; nu putem avea un index mai mic decat 1
    cmp ecx, 0
    jle endfib ; deja avem -1 valoarea de return
    inc eax ; revine la 0 daca nu avem index mai mic de 1
   cmp ecx, 1 ; caz de baza n = 1, f(1) = 0
    je endfib
    cmp ecx, 2 ; caz de baza n = 2, f(2) = 1
    je endfibplus1
    ; daca nu avem caz de baza, trebuie apel recursiv
    ; prima parte ( f(n-1) )
    dec ecx ; decrementam ecx ca sa devina n - 1
    push ecx ; salvam ecx deoarece se va modifica in apelurile recursive +
              ;parametrul pentru apelul recursiv
    call fibo ; primul apel recursiv
    pop ecx ; restauram stiva
    ; acum avem in eax prima parte
    ; a doua parte ( f(n-2) )
    push eax ; salvam f(n-1)
    dec ecx ; n - 1 - 1 = n - 2
    push ecx ; arg functiei
    call fibo
    add esp, 4 ; restauram stiva
   pop edx ; luam prima parte in edx
    add eax, edx ; adaugam in eax prima parte si a doua parte
    jmp endfib ; skip incremetarea cu 1
    endfibplus1:
    inc eax ; 0 + 1 = 1
    endfib:
leave
ret

## CC_V2_2024
### ARGUMENTE IN LINIA DE COMANDA
- **pow corectat**