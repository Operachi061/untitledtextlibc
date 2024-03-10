BUILDDIR=build
CFLAGS=-Wall -Wpedantic -c -I$(shell pwd)src/include 
ARCH=$(shell uname -m)
CC=cc
AS=as
AR=ar
SRCS=$(shell find ./arch/$(ARCH)/*.s)
SRCC=$(shell find . -type f -name '*.c')
OBJC=$(shell find . -type f -name '*.c' | sed 's/\b.c\b/.o/g')
OBJS=$(shell find ./arch/$(ARCH)/*.s | sed 's/\b.s\b/.o/g')
OBJ=$(OBJS) $(OBJC)

all: $(OBJ) ./out/libc.so ./out/libc.a

%.o: %.c
		$(CC) $(CFLAGS) -o $@ $^ 

%.o: %.s
		$(AS) -o $@ $^  

./out/libc.so: $(OBJ) 
		$(CC) -nostdlib -shared -o $@ $^

./out/libc.a: $(OBJ) 
		$(AR) rcs $@ $^
		
clean:
		rm -rf $(OBJ) ./out/*

.PHONY: clean 
