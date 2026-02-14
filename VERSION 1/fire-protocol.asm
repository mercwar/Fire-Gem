; =============================================================
;  AVIS PROTOCOL ENGINE [VERSION 1]
;  FILE: fire-protocol.asm
; =============================================================

section .data
    log_path db "VERSION 1/fire-log/fire-protocol.avis", 0
    avis_hdr db "AVIS", 0x01, 0x00
    hdr_len  equ 6

section .text
    global FIRE_PROTOCOL_STRIKE

FIRE_PROTOCOL_STRIKE:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi

    ; 1. OPEN THE VAULT LOG
    mov rax, 2          ; sys_open
    mov rdi, log_path
    mov rsi, 1089       ; O_CREAT|WRONLY|APPEND
    mov rdx, 0644o
    syscall
    mov r12, rax

    ; 2. STRIKE AVIS HEADER
    mov rax, 1
    mov rdi, r12
    mov rsi, avis_hdr
    mov rdx, hdr_len
    syscall

    ; 3. STRIKE BODY
    pop rdx
    pop rsi
    mov rax, 1
    mov rdi, r12
    syscall

    ; 4. CLOSE
    mov rax, 3
    mov rdi, r12
    syscall

    leave
    ret
