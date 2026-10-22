section .data

fmt_int db "%d ", 0
fmt_int_seq db "%d, ", 0
fmt_arr db "arr = ", 0
fmt_len db "len = %d", 10, 0
fmt_cap db "cap = %d", 10, 0

data dd 50, 70, 30, 10, 20

struc vector
	arr:	resd 1
	len:	resd 1
	cap:	resd 1
endstruc

section .text

; TODO a; Initialize a variable `dummy` of type `vector` with the values (data, 5, 5)

; TODO a: Create a function called `void vector_print(struct vector *v)`
; The function should print the contents of arr, the length and the cap.
; Note: Check `results.txt` for the format
vector_print:
	push ebp
	mov ebp, esp

	leave
	ret

; TODO b: Initialize a variable called `vec` of type `vector` with the following values(0, 0, 0)

; TODO b: Create the function `void vector_init(struct vector *v, int cap)` that allocates
; space on the heap for `cap` integers and uses the pointer `v.arr` to store that location
vector_init:
	push ebp
	mov ebp, esp

	leave
	ret

; TODO c: Create the function `void vector_push(struct vector *v, int value)` that adds
; `value` to the end of the vector. In case there is not enough space, the function will
; allocate 2 times the current space in the vector.
vector_push:
	push ebp
	mov ebp, esp

	leave
	ret

sum:
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8]
	mov ebx, [ebp + 12]
	add eax, ebx

	leave
	ret

; TODO d: Create the function `void vector_reduce(struct vector *v, int (*f)(int, int) , int *acc)`
; that applies the function `f` on each element of the vector, starting with `acc` as the initial value.
; The result will be stored in acc.
; HINT: acc = f(acc, v.arr[i])
vector_reduce:
	push ebp
	mov ebp, esp

	leave
	ret

extern printf
extern rand
global main

main:
	push ebp
	mov ebp, esp

	; TODO a: Call `vector_print` on the variable `dummy`

	; TODO b: Call `vector_init` on the variable `vec` with a capacity of 2.
	; Generate two random numbers with `rand` and set the first two elements of `vec.arr` to them
	; Afterwards call `vector_print` on `vec`.

	; TODO c: Call `vector_push` on the variable `vec` with the contents of the array `data`
	; Call `vector_print` on the variable afterwards

	; TODO d: Call `vector_reduce` in order to get the sum of the elements of the vector `vec`

	xor eax, eax
	leave
	ret
