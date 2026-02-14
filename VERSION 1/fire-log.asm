; =============================================================================
;  AVIS-CORE // LLM-LOG ENCAPSULATOR
;  FILE: fire-log.asm
;  GOVERNANCE: CVBGOD // STATUS: HARDWARE_LOCK
; =============================================================================

section .data
    log_path  db "VERSION 1/fire-log/fire-protocol.avis", 0
    avis_hdr  db "AVIS", 0x01, 0x00          ; Magic + Ver
    llm_tag   db "[LLM-LOG-OBJ]", 0x00      ; Fancy Object Tag
    tag_len   equ 14

section .text
    global FIRE_LOG_STRIKE

FIRE_LOG_STRIKE:
    push rbp
    mov rbp, rsp
    push rdi            ; Save Body Pointer
    push rsi            ; Save Body Length

    ; 1. OPEN VAULT (sys_open: 2)
    mov rax, 2          
    mov rdi, log_path
    mov rsi, 1089       ; O_CREAT|WRONLY|APPEND
    mov rdx, 0644o
    syscall
    mov r12, rax        ; r12 = FD

    ; 2. STRIKE AVIS MAGIC HEADER
    mov rax, 1          ; sys_write
    mov rdi, r12
    mov rsi, avis_hdr
    mov rdx, 6
    syscall

    ; 3. STRIKE LLM-LOG OBJECT SIGNATURE
    mov rax, 1
    mov rdi, r12
    mov rsi, llm_tag
    mov rdx, tag_len
    syscall

    ; 4. STRIKE PAYLOAD
    pop rdx             ; Restore Length
    pop rsi             ; Restore Pointer
    mov rax, 1
    mov rdi, r12
    syscall

    ; 5. CLOSE (sys_close: 3)
    mov rax, 3
    mov rdi, r12
    syscall

    leave
    ret
