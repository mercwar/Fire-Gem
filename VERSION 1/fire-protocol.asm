; =============================================================================
;  AVIS PROTOCOL ENGINE [VERSION 1]
;  FILE: fire-protocol.asm
;  PURPOSE: Encapsulate Logs in AVIS Header for CYHY Terminal
; =============================================================================

section .data
    protocol_path db "VERSION 1/fire-protocol.avis", 0
    avis_magic    db "AVIS", 0x01, 0x00    ; Magic + Version
    magic_len     equ 6

section .text
    global FIRE_PROTOCOL_STRIKE

FIRE_PROTOCOL_STRIKE:
    push rbp
    mov rbp, rsp
    push rdi            ; Save Body
    push rsi            ; Save Length

    ; 1. OPEN PROTOCOL FILE (O_APPEND)
    mov rax, 2          
    mov rdi, protocol_path
    mov rsi, 1089       ; O_CREAT|WRONLY|APPEND
    mov rdx, 0644o
    syscall
    mov r12, rax

    ; 2. STRIKE AVIS PROTOCOL HEADER
    mov rax, 1
    mov rdi, r12
    mov rsi, avis_magic
    mov rdx, magic_len
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
