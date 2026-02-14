; VERSION 1/fire-log.asm
section .data
    log_path db "VERSION 1/fire-log/fire-protocol.avis", 0
    avis_hdr db "AVIS [LLM-LOG-OBJ]", 0
    html_pre db "<avis-obj data-lvl='2'>", 0
    html_suf db "</avis-obj>", 0xa, 0

section .text
    global FIRE_LOG_STRIKE

FIRE_LOG_STRIKE:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi

    ; 1. OPEN VAULT
    mov rax, 2          ; open
    mov rdi, log_path
    mov rsi, 1089       ; O_CREAT|WRONLY|APPEND
    mov rdx, 0644o
    syscall
    mov r12, rax

    ; 2. STRIKE HTML WRAPPER (Start)
    mov rax, 1
    mov rdi, r12
    mov rsi, html_pre
    mov rdx, 23
    syscall

    ; 3. STRIKE BODY
    pop rdx
    pop rsi
    mov rax, 1
    mov rdi, r12
    syscall

    ; 4. STRIKE HTML WRAPPER (End)
    mov rax, 1
    mov rdi, r12
    mov rsi, html_suf
    mov rdx, 12
    syscall

    mov rax, 3          ; close
    mov rdi, r12
    syscall
    leave
    ret
