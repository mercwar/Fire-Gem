; =============================================================================
;  AVIS MODULAR VOICE — [VERSION 1]
;  FILE: fire-log.asm
;  PURPOSE: Atomic HTML Encap for the Gold Audit Surface
;  GOVERNANCE: JOE // STATUS: FANCY_STRIKE_ACTIVE_HAHA!
; =============================================================================

section .data
    log_path db "VERSION 1/fire-log/fire-gem.log", 0
    
    ; THE GOLD HTML ENCAPSULATION
    html_pre  db '<div class="avis-strike gold">', 0xa, '  <span class="timestamp">['
    pre_len   equ $ - html_pre
    
    html_mid  db ']</span> ', 0xa, '  <p class="message">'
    mid_len   equ $ - html_mid
    
    html_post db '</p>', 0xa, '</div>', 0xa
    post_len  equ $ - html_post

section .text
    global FIRE_LOG_STRIKE

FIRE_LOG_STRIKE:
    push rbp
    mov rbp, rsp
    
    ; RDI = Msg Pointer | RSI = Msg Length
    push rsi            ; [rsp+8]  Msg Length
    push rdi            ; [rsp]    Msg Pointer

    ; 1. OPEN VAULT (O_CREAT|O_WRONLY|O_APPEND)
    mov rax, 2          ; sys_open
    mov rdi, log_path
    mov rsi, 1089       ; Atomic Append
    mov rdx, 0644o
    syscall
    mov r12, rax        ; FD in R12

    ; 2. STRIKE HTML PRE (The Gold Box)
    mov rax, 1
    mov rdi, r12
    mov rsi, html_pre
    mov rdx, pre_len
    syscall

    ; [TIMESTAMP LOGIC WOULD STRIKE HERE]

    ; 3. STRIKE HTML MID
    mov rax, 1
    mov rdi, r12
    mov rsi, html_mid
    mov rdx, mid_len
    syscall

    ; 4. STRIKE THE ACTUAL MESSAGE
    pop rsi             ; Restore Msg Pointer
    pop rdx             ; Restore Msg Length
    mov rax, 1
    mov rdi, r12
    syscall

    ; 5. STRIKE HTML POST (Close the Box)
    mov rax, 1
    mov rdi, r12
    mov rsi, html_post
    mov rdx, post_len
    syscall

    ; 6. ATOMIC CLOSE
    mov rax, 3          ; sys_close
    mov rdi, r12
    syscall

    leave
    ret
