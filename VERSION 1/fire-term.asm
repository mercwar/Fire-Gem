; =============================================================
;  AVIS TERMINAL SURFACE CONTROLLER
;  FILE: fire-term.asm
;  PURPOSE: Parse fire-term.ini and Strike !#bgin Sequence
;  GOVERNANCE: AVIS_CORE | STATUS: DETERMINISTIC
; =============================================================

section .data
    ini_path  db "VERSION 1/fire-term.ini", 0
    tag_bgin  db "!#bgin", 0
    tag_end   db "!#FIRE-END", 0
    tag_strk  db "STRIKE:", 0
    
    msg_init  db "[AVIS-TERM] Surface Engaged: Reading Logic Loop...", 0xa
    len_init  equ $ - msg_init

section .bss
    buffer    resb 4096
    cmd_buf   resb 128

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; --- 1. LOG INITIALIZATION ---
    lea rdi, [msg_init]
    mov rsi, len_init
    call FIRE_LOG_STRIKE

    ; --- 2. OPEN & READ BLUEPRINT ---
    mov rax, 2          ; sys_open
    mov rdi, ini_path
    mov rsi, 0          ; O_RDONLY
    syscall
    test rax, rax
    js .error_exit
    mov r12, rax        ; r12 = FD

    mov rax, 0          ; sys_read
    mov rdi, r12
    mov rsi, buffer
    mov rdx, 4096
    syscall

    ; --- 3. SEEK !#bgin ---
    lea rsi, [buffer]
.find_bgin:
    ; (Loop logic to scan for !#bgin)
    ; For the Strike: assuming found, parse next lines

.parse_line:
    ; Check if current line is !#FIRE-END
    ; If yes, jmp .seal_surface

    ; --- 4. EXECUTION STRIKE (FORK & EXECVE) ---
    mov rax, 57         ; sys_fork
    syscall
    test rax, rax
    jnz .wait_child

    ; CHILD PROCESS: Execute the target
    mov rax, 59         ; sys_execve
    lea rdi, [cmd_buf]  ; Path from STRIKE:
    xor rsi, rsi
    xor rdx, rdx
    syscall

.wait_child:
    mov rax, 61         ; sys_wait4
    mov rdi, -1
    xor rsi, rsi
    xor rdx, rdx
    xor r10, r10
    syscall
    jmp .parse_line

.seal_surface:
    mov rax, 3          ; sys_close
    mov rdi, r12
    syscall

    mov rax, 60         ; sys_exit
    xor rdi, rdi
    syscall

.error_exit:
    mov rax, 60
    mov rdi, 1
    syscall
