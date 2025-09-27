#!/bin/bash

#$main='main.c'

nasm -f elf64 shellcode_loader.asm -o memstack.o
#nasm -f elf64 asm_utils.asm -o utils.o
gcc -c main.c -o main.o
gcc memstack.o main.o  -o app -no-pie
rm memstack.o main.o 
