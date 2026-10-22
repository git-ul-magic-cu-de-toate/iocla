ASM = nasm
CC = gcc
CFLAGS = -Wall -m32 -fno-stack-protector -mpreferred-stack-boundary=2 -fno-PIC
LDFLAGS = -m32 -no-pie


.PHONY: all clean

all: main

main: main.o phone.o file.o

main.o: main.c
	$(CC) $(CFLAGS) -g -c -o $@ $<

file.o: file.asm
	$(ASM) -f  elf32 -g -o $@ $<

clean:
	-rm -f *~
	-rm -f file.o main.o test.o main

