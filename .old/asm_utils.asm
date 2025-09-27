section .data
hex_digits db "0123456789ABCDEF"

section .bss
linebuf resb 4

global PrintHex
section .text

PrintHex:
.nextblock:
    ; check if rcx == 0 (done)
    test rcx, rcx
    jz .done

    ; print 16 bytes as two 8-byte groups
    mov rdi, linebuf     ; buffer pointer
    mov rbx, 0           ; byte index (0..15)

.convert_loop:
    mov al, byte [rsi + rbx]    ; load one byte
    mov bl, al
    shr al, 4                   ; high nibble
    movzx eax, al
    mov al, [hex_digits + rax]
    mov [rdi], al
    inc rdi

    mov al, bl
    and al, 0x0F                ; low nibble
    movzx eax, al
    mov al, [hex_digits + rax]
    mov [rdi], al
    inc rdi

    ; add space after 8 bytes
    inc rbx
    cmp rbx, 8
    jne .no_space
    mov byte [rdi], ' '
    inc rdi
.no_space:

    cmp rbx, 16
    jl .convert_loop

    ; add newline
    mov byte [rdi], 10
    inc rdi

    ; write syscall
    mov rax, 1        ; sys_write
    mov rdi, 1        ; stdout
    mov rsi, linebuf
    sub rdi, rsi      ; OOPS need len
    ; instead compute len
    mov rdx, rdi
    sub rdx, linebuf  ; length written
    mov rsi, linebuf
    mov rax, 1
    mov rdi, 1
    syscall

    ; advance source
    add rsi, 16
    dec rcx
    jmp .nextblock

.done:
    ret

