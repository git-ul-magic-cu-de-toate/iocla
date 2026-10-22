CFLAGS = -Wall -Wextra -m32 -Iinclude -fno-stack-protector -mpreferred-stack-boundary=2 -fno-PIC
LDFLAGS = -m32 -no-pie

# TODO: complete the Makefile to make the linking work

all: main.o file.o test.o directory.o op.o
	$(CC) $(CFLAGS) $^ -o main

op.o: src/op.c
	$(CC) $(CFLAGS) -c -o op.o src/op.c