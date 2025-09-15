section .data
	dump_size dd 256
	msg_stack db "-- STACK -- ", 0xa
	done_stack db "-- DONE STACK -- ", 0xa
	dstack_len equ $ - done_stack
	stack_len equ $ - msg_stack
	newline db 0xa
	
section .bss
	dumped : resb 16
	pid : resq 1
	regs : resq 27
	;struct user_regs_struct {
    	;unsigned long r15, r14, r13, r12, rbp, rbx,
        ;         r11, r10, r9, r8,
        ;         rax, rcx, rdx, rsi, rdi,
        ;         orig_rax,
        ;         rip, cs, eflags, rsp, ss,
        ;         fs_base, gs_base,
        ;         ds, es, fs, gs;
	;};



global Memory
global ViewMemory
global ModifyMemory
extern PrintHex
section .text

Memory:
	push rbp
	mov rbp, rsp
	
	mov [pid], rdi

	; ptrace_attach = 16
	mov rax, 101
	mov rdi, 12; ; PTRACE_GETREGS
	mov rsi, [pid]
	lea rdx, [regs]
	xor r10, r10
	syscall

	cmp rax, -1
	je .done

	mov rax, 1
	mov rdi, 1
	mov rsi, msg_stack
	mov rdx, stack_len
	syscall

	xor rcx, rcx
	;mov r8, [regs+19*8] 
.DUMP_STACK:
	cmp rcx, [dump_size]
	jge .done

	; dump stack


	mov rax, 101
	mov rdi, 2 ; PTRACE_PEEKDATA
	mov rsi, [pid]
	mov rdx, [r8+rcx] ; [regs + 19*8] ; rsp
	xor r10, r10
	syscall
	
	; store first 8 bytes
	mov [dumped], rax

	mov rax, 101
	mov rdi, 2
	mov rsi, [pid]
	xor r10, r10
	syscall
	
	; store second 8 bytes
	mov [dumped+8], rax
	
	; output
	lea rdi, [dumped]
	call PrintHex

	add rcx, 16
	jmp .DUMP_STACK
	
.done:	
	mov rax, 1
	mov rdi, 1
	mov rsi, done_stack
	mov rdx, dstack_len
	syscall
	
	mov rax, 0
	mov rsp, rbp
	pop rbp
	ret

