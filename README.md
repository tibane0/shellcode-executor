# Shellcode Executor/ Tester

This is a project meant for learning x86_64 assembly and linux internals: a small tool to load, run and analyze raw shellcode in a controlled environment.

## Goals 
- Learn assembly `(x86_64)` by doing.
- Work with linux syscalls:
	- Memory management
	- Process control
- Build a practical tool for **reverse engineering and binary exploitation**.

## Features
- Load and execute raw shellcode in a controlled environment.
- Test shellcode under different protection settings.
- Debug and analyze shellcode bahavior.
- Generate basic shellcode stubs for testing.

## Implementation Plan

### Phase 1
Basic shellcode loader
- Allocate executable memory and copy shellcode to allocated memory
- create function pointer and execute
- handle crashes

### phase 2
Safe execution environment
- Fork based isolantion (execute in child process)
- Signal handling for segmentation faults
- Timeout mechanisms
- sandboxing:
	- seccomp filters
	- linux namespaces
- Memory protection toggling:
	- NX/DEP
	- Stack canary
	- RELRO
	- ASLR
	- PIE

### Phase 3
Analysis Features
- Register state before/after execution
- Syscall tracing
- memory mapping display
- step-by-step execution


