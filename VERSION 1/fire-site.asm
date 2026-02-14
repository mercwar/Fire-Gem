; =============================================================
;  AVIS SEO STUB
;  FILE: fire-site.asm
;  PURPOSE: Single-strike handoff to SEO Batch (fire-site.sh)
; =============================================================

section .data
    bot_path db "VERSION 1/fire-site.sh", 0
    argv     dq bot_path, 0
    envp     dq 0

section .text
    global _start

_start:
    ; --- THE SINGLE CALL ---
    mov rax, 59         ; sys_execve
    mov rdi, bot_path   ; Filename
    lea rsi, [argv]     ; Argument list
    lea rdx, [envp]     ; Environment
    syscall

    ; Fallback exit if exec fails
    mov rax, 60
    xor rdi, rdi
    syscall
