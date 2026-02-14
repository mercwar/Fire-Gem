; =============================================================================
;  AVIS MODULAR VOICE [VERSION 1]
;  FILE: fire-log.asm
;  PURPOSE: Primary Disk Strike for Identity: VERSION 1
;  GOVERNANCE: CVBGOD // STATUS: DUMB_LOAD_READY
; =============================================================================

section .data
    log_path db "VERSION 1/fire-gem.log", 0
    avis_hdr db "AVIS", 0x01, 0x00    ; Magic + Protocol Ver
    hdr_len  equ 6

section .text
    global FIRE_LOG_STRIKE

; -----------------------------------------------------------------------------
; FIRE_LOG_STRIKE
; RDI = String Pointer | RSI = String Length
; -----------------------------------------------------------------------------
FIRE_LOG_STRIKE:
    push rbp
    mov rbp, rsp
    push rdi            ; Save Body Pointer
    push rsi            ; Save Body Length

    ; 1. OPEN LOG (sys_open: 2)
    mov rax, 2          
    mov rdi, log_path
    mov rsi, 1089       ; O_CREAT | O_WRONLY | O_APPEND
    mov rdx, 0644o      ; Permissions
    syscall
    mov r12, rax        ; r12 = File Descriptor (FD)

    ; 2. STRIKE AVIS PROTOCOL HEADER (Encapsulation)
    mov rax, 1          ; sys_write
    mov rdi, r12
    mov rsi, avis_hdr
    mov rdx, hdr_len
    syscall

    ; 3. STRIKE DATA BODY
    pop rdx             ; Restore length to RDX
    pop rsi             ; Restore buffer pointer to RSI
    mov rax, 1          
    mov rdi, r12
    syscall

    ; 4. CLOSE LOG (sys_close: 3)
    mov rax, 3          
    mov rdi, r12
    syscall

    leave
    ret
