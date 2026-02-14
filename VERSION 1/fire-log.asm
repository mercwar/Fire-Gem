; =============================================================================
;  AVIS MODULAR VOICE [VERSION 1]
;  FILE: fire-log.asm
; =============================================================================

section .data
    log_path db "VERSION 1/fire-gem.log", 0
    avis_hdr db "AVIS", 0x01, 0x00
    hdr_len  equ 6

section .text
    global FIRE_LOG_STRIKE

; PROCEDURE ONLY - NO _START LABEL HERE
FIRE_LOG_STRIKE:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi

    mov rax, 2          ; sys_open
    mov rdi, log_path
    mov rsi, 1089       ; O_CREAT|WRONLY|APPEND
    mov rdx, 0644o
    syscall
    mov r12, rax

    mov rax, 1          ; sys_write
    mov rdi, r12
    mov rsi, avis_hdr
    mov rdx, hdr_len
    syscall

    pop rdx             ; Restore length
    pop rsi             ; Restore buffer
    mov rax, 1
    mov rdi, r12
    syscall

    mov rax, 3          ; sys_close
    mov rdi, r12
    syscall

    leave
    ret
