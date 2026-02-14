; =============================================================================
;  AVIS MODULAR VOICE [VERSION 1]
;  FILE: fire-log.asm
;  PURPOSE: Atomic Open/Write/Close to prevent EMPTY .avis files
; =============================================================================

section .data
    log_path db "VERSION 1/fire-log/fire-protocol.avis", 0

section .text
    global FIRE_LOG_STRIKE

FIRE_LOG_STRIKE:
    push rbp
    mov rbp, rsp
    
    ; RDI = Message Pointer | RSI = Message Length
    push rsi            ; Save Length
    push rdi            ; Save Pointer

    ; 1. OPEN LOG (O_CREAT | O_WRONLY | O_APPEND)
    mov rax, 2          ; sys_open
    mov rdi, log_path
    mov rsi, 1089       ; [O_CREAT|WRONLY|APPEND]
    mov rdx, 0644o
    syscall
    mov r12, rax        ; Save File Descriptor (FD)

    ; 2. WRITE DATA
    pop rsi             ; Restore Message Pointer to RSI
    pop rdx             ; Restore Message Length to RDX
    mov rax, 1          ; sys_write
    mov rdi, r12        ; Target FD
    syscall

    ; 3. FORCE FLUSH & CLOSE
    mov rax, 3          ; sys_close
    mov rdi, r12
    syscall

    leave
    ret
