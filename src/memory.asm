section .data
	dump_size dd 256
	msg_stack db "-- STACK -- ", 0xa
	stack_len equ $ - msg_stack

	done_stack db "-- DONE STACK -- ", 0xa
	dstack_len equ $ - done_stack
	
	 err_attach   db "ptrace attach failed", 0x0A
    	err_attach_len equ $ - err_attach
    	err_getregs  db "ptrace getregs failed", 0x0A
    	err_getregs_len equ $ - err_getregs

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

.ptrace_attach:
	; ptrace_attach = 16
	mov rax, 101
	mov rdi, 16
	mov rsi, [pid]
	xor rdx, rdx
	xor r10, r10
	syscall

	cmp rax, 0
	jl .err_attach
	
.ptrace_getregs:
	mov rax, 101
	mov rdi, 12; ; PTRACE_GETREGS
	mov rsi, [pid]
	lea rdx, [regs]
	xor r10, r10
	syscall

	cmp rax, 0
	jl .err_getregs

	; print -- stack --
	mov rax, 1
	mov rdi, 1
	mov rsi, msg_stack
	mov rdx, stack_len
	syscall

.DUMP_STACK:
	xor rcx, rcx
	mov r8, [regs+19*8]

.stack_loop:
	cmp rcx, [dump_size]
	jge .detach

.ptrace_peekdata_1:
	; dump stack
	mov rax, 101
	mov rdi, 2 ; PTRACE_PEEKDATA
	mov rsi, [pid]
	;lea rdx, [r8+rcx] ; [regs + 19*8] ; rsp
	mov rdx, r8
	add rdx, rcx
	xor r10, r10
	syscall
	
	cmp rax, 0
	jl .detach
	
	; store first 8 bytes
	mov [dumped], rax

.ptrace_peekdata_2:
	mov rax, 101
	mov rdi, 2
	mov rsi, [pid]
	;lea rdx, [r8+rcx]
	mov rdx, r8
	add rdx, rcx
	add rdx, 8
	xor r10, r10
	syscall

	cmp rax, 0
	jl .detach
	
	; store second 8 bytes
	mov [dumped+8], rax
	
	; output
	lea rdi, [dumped]
	mov rsi, dumped 
	call PrintHex

	add rcx, 16
	jmp .stack_loop
	

.detach:
	mov rax, 101
	mov rdi, 17
	mov rsi, [pid]
	xor rdx, rdx
	xor r10, r10
	syscall

.done_stack:	
	; print -- done stack --
	mov rax, 1
	mov rdi, 1
	mov rsi, done_stack
	mov rdx, dstack_len
	syscall
	
.done:
	mov rax, 0
	mov rsp, rbp
	pop rbp
	ret

.err_attach:
    ; write error and return -1
    mov rax, 1
    mov rdi, 2
    mov rsi, err_attach
    mov rdx, err_attach_len
    syscall
    mov rax, -1
    mov rsp, rbp
    pop rbp
    ret

.err_getregs:
    mov rax, 1
    mov rdi, 2
    mov rsi, err_getregs
    mov rdx, err_getregs_len
    syscall
    mov rax, -1
    mov rsp, rbp
    pop rbp
    ret
