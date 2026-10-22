ASM = nasm
ASM_FLAGS = -f elf32 -g -Fdwarf
CC = gcc
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: rectangle

rectangle: rectangle.o

rectangle.o: rectangle.asm
	$(ASM) $(ASM_FLAGS) -o $@ $<

clean:
	-rm -f *~
	-rm -f rectangle.o rectangle
