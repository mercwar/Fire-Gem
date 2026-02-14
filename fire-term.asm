; =============================================================
;  AVIS TERMINAL SURFACE CONTROLLER
;  FILE: fire-term.asm
;  PURPOSE: Execute the [AVIS] Sector in !#bgin Sequence
; =============================================================

section .data
    ini_path db "fire-gem/fire-term.ini", 0
    avis_tag db "[AVIS]", 0
    bgin_tag db "!#bgin", 0
    end_tag  db "!#FIRE-END", 0
    strike   db "STRIKE:", 0

section .bss
    buffer   resb 4096
    cmd_path resb 128

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; 1. OPEN & READ THE BLUEPRINT
    mov rax, 2          ; sys_open
    mov rdi, ini_path
    mov rsi, 0          ; O_RDONLY
    syscall
    mov r12, rax

    mov rax, 0          ; sys_read
    mov rdi, r12
    mov rsi, buffer
    mov rdx, 4096
    syscall

    ; 2. SEARCH FOR [AVIS] SECTOR
    lea rsi, [buffer]
.find_avis:
    ; (Loop until "[AVIS]" is found in buffer)

    ; 3. SEARCH FOR !#bgin
.find_bgin:
    ; (Loop until "!#bgin" is found)

    ; 4. EXECUTION LOOP
.strike_loop:
    ; (Parse "STRIKE: [binary.exe]" and extract name)
    ; (Check for "!#FIRE-END" to break)
    
    ; 5. SYSTEM STRIKE (fork + execve)
    ; (Calls avis-fvs.exe, fire-seed.exe, etc.)

    ; 6. EXIT
    mov rax, 60
    xor rdi, rdi
    syscall
