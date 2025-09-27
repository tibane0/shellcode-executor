#!/bin/bash


nasm -f elf64 memory.asm -o memstack.o
#nasm -f elf64 asm_utils.asm -o utils.o
gcc -c main.c -o main.o
gcc memstack.o main.o  -o app -no-pie
rm memstack.o main.o 
