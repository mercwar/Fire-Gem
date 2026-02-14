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

FIRE_LOG_STRIKE:
    push rbp
    mov rbp, rsp
    
    ; RDI = Pointer to Message | RSI = Length of Message
    push rsi
    push rdi

    ; 1. OPEN LOG (O_CREAT | O_WRONLY | O_APPEND)
    mov rax, 2          ; sys_open
    mov rdi, log_path
    mov rsi, 1089       ; [O_CREAT|WRONLY|APPEND]
    mov rdx, 0644o
    syscall
    mov r12, rax        ; Save File Descriptor

    ; 2. WRITE AVIS HEADER (The Seal)
    mov rax, 1          ; sys_write
    mov rdi, r12
    mov rsi, avis_hdr
    mov rdx, hdr_len
    syscall

    ; 3. WRITE THE ACTUAL MESSAGE (The Data)
    pop rsi             ; Restore Pointer to msg
    pop rdx             ; Restore Length
    mov rax, 1          ; sys_write
    mov rdi, r12
    syscall

    ; 4. CLOSE
    mov rax, 3          ; sys_close
    mov rdi, r12
    syscall

    leave
    ret
