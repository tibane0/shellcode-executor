; syscalls
%define SYS_MMAP 9
%define SYS_PTRACE 101
%define SYS_WRITE 1
%define SYS_READ 0
%define SYS_EXECVE 59
%define SYS_FORK 57
%define SYS_OPEN 2
;mmap args
%define RWX 0x7
%define AP 0x22
; ptrace args
%define PTRACE_ATTACH 16
%define PTRACE_GETREGS 12
%define PTRACE_PEEKDATA 2
%define PTRACE_DETACH 17

%define TRUE 1
%define FALSE 0

%macro MEMCPY 3
	mov rdi, %1; dst
	mov rsi, %2; src
	mov rcx, %3
	rep movsb
%endmacro

section .bss
	addr : resb 8
section .data

section .text
	global exec_shellcode
exec_shellcode:
	push rbp
	mov rbp, rsp
	
	mov r12, rdi
	mov r13, rsi ; len

	mov rax, SYS_MMAP
	xor rdi, rdi
	mov rsi, r13
	mov rdx, RWX
	mov r10, AP
	mov r8, -1
	mov r9, 0
	syscall
	
	test rax, rax
	js .MMAP_FAILED

	mov [addr], rax

	MEMCPY [addr], r12, r13
	
	mov rax, [addr]
	call rax ; execute
	mov rax, TRUE
	jmp .DONE
.MMAP_FAILED:
	mov rax, FALSE
.DONE:
	mov rsp, rbp
	pop rbp
	ret
