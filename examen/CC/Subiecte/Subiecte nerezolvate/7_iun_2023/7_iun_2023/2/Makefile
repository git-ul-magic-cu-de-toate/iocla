ASM = nasm
CC = gcc
CFLAGS = -Wall -m32 -Wno-implicit-function-declaration
LDFLAGS = -m32

.PHONY: all clean

all: arr_proc

arr_proc: arr_proc.o

arr_proc.o: arr_proc.asm
	$(ASM) -I/usr/share/sasm/include/ -f elf32 -o $@ $<

clean:
	-rm -f *~
	-rm -f arr_proc.o arr_proc
