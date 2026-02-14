; =============================================================================
;  AVIS ENCAPSULATED VOICE [VERSION 1]
;  FILE: fire-log.asm
; =============================================================================

section .data
    log_path db "VERSION 1/fire-gem.log", 0
    avis_hdr db 0x41, 0x56, 0x49, 0x53    ; "AVIS" Magic Header
    hdr_len  equ 4

section .text
    global FIRE_LOG_STRIKE

FIRE_LOG_STRIKE:
    push rbp
    mov rbp, rsp
    push rdi            ; Save Body Pointer
    push rsi            ; Save Body Length

    ; 1. OPEN VERSION 1 LOG
    mov rax, 2          ; sys_open
    mov rdi, log_path
    mov rsi, 1089       ; O_CREAT|WRONLY|APPEND
    mov rdx, 0644o
    syscall
    mov r12, rax        ; r12 = FD

    ; 2. STRIKE AVIS HEADER (Encapsulation)
    mov rax, 1          ; sys_write
    mov rdi, r12
    mov rsi, avis_hdr
    mov rdx, hdr_len
    syscall

    ; 3. STRIKE LOG BODY (The Object/Text)
    pop rdx             ; Restore Length
    pop rsi             ; Restore Body Pointer
    mov rax, 1          ; sys_write
    mov rdi, r12
    syscall

    ; 4. CLOSE
    mov rax, 3
    mov rdi, r12
    syscall

    leave
    ret
