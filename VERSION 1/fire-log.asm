; =============================================================
;  AVIS LLM-LOG ENCAPSULATOR [VERSION 1]
;  FILE: fire-log.asm
;  PURPOSE: Forge a Fancy Object for every Log Strike
; =============================================================

section .data
    log_path  db "VERSION 1/fire-gem.log", 0
    avis_hdr  db "AVIS", 0x01          ; Magic + Protocol Ver
    llm_tag   db "[LLM-LOG-OBJ]", 0    ; Fancy Object Identifier
    tag_len   equ 14

section .text
    global FIRE_LOG_STRIKE

FIRE_LOG_STRIKE:
    push rbp
    mov rbp, rsp
    push rdi            ; Save Body Pointer
    push rsi            ; Save Body Length

    ; 1. OPEN LOG (VERSION 1 AUTHORITY)
    mov rax, 2          ; sys_open
    mov rdi, log_path
    mov rsi, 1089       ; O_CREAT|WRONLY|APPEND
    mov rdx, 0644o
    syscall
    mov r12, rax        ; r12 = FD

    ; 2. STRIKE AVIS MAGIC
    mov rax, 1
    mov rdi, r12
    mov rsi, avis_hdr
    mov rdx, 5
    syscall

    ; 3. STRIKE FANCY LLM-LOG OBJECT TAG
    mov rax, 1
    mov rdi, r12
    mov rsi, llm_tag
    mov rdx, tag_len
    syscall

    ; 4. STRIKE DATA BODY (The Proof)
    pop rdx             ; Restore Length
    pop rsi             ; Restore Pointer
    mov rax, 1          ; sys_write
    mov rdi, r12
    syscall

    ; 5. CLOSE
    mov rax, 3
    mov rdi, r12
    syscall

    leave
    ret
