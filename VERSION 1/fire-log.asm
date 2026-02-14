; fire-log.asm
section .data
    log_path db "VERSION 1/fire-gem.log", 0

section .text
    global FIRE_LOG_STRIKE

FIRE_LOG_STRIKE:
    push rbp
    mov rbp, rsp
    mov r10, rsi
    mov r11, rdi
    mov rax, 2          ; sys_open
    mov rdi, log_path
    mov rsi, 1089       ; O_CREAT|WRONLY|APPEND
    mov rdx, 0644o
    syscall
    mov rdi, rax
    mov rax, 1          ; sys_write
    mov rsi, r11
    mov rdx, r10
    syscall
    mov rax, 3          ; sys_close
    syscall
    leave
    ret
