; =============================================================
;  AVIS MODULAR VOICE [VERSION 1]
;  FILE: fire-log.asm
; =============================================================
section .data
    log_path db "VERSION 1/fire-gem.log", 0

section .text
    global FIRE_LOG_STRIKE

FIRE_LOG_STRIKE:
    push rbp
    mov rbp, rsp
    ; Open/Append to log logic
    mov rax, 2          ; sys_open
    mov rdi, log_path
    mov rsi, 1089       ; O_CREAT|WRONLY|APPEND
    mov rdx, 0644o
    syscall
    mov r12, rax        ; FD

    mov rax, 1          ; sys_write
    mov rdi, r12
    ; RSI/RDX passed from caller
    syscall

    mov rax, 3          ; sys_close
    mov rdi, r12
    syscall
    leave
    ret
