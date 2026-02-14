; =============================================================================
;  AVIS MASTER ENGINE — [ORCHESTRATOR v4.0]
;  FILE: fire-gem.asm
;  PURPOSE: Parse fire-term.ini [AVIS] Sector and Strike Hardware Chain
;  GOVERNANCE: AVIS_CORE | STATUS: DETERMINISTIC
; =============================================================================

section .data
    ini_path  db "fire-gem/fire-term.ini", 0
    avis_tag  db "[AVIS]", 0
    bgin_tag  db "!#bgin", 0
    end_tag   db "!#FIRE-END", 0
    strike_id db "STRIKE:", 0
    
    msg_boot  db "[AVIS-GEM] Master Engine Ignition: Modular Log Linked.", 0xa
    len_boot  equ $ - msg_boot
    msg_loop  db "[AVIS-GEM] Searching [AVIS] Sector for Logic Loop...", 0xa
    len_loop  equ $ - msg_loop

section .bss
    ini_buffer resb 4096
    cmd_buffer resb 128

section .text
    global _start
    extern FIRE_LOG_STRIKE  ; Linked from fire-log.o in YML/SH level

_start:
    ; --- 1. BOOTSTRAP LOGGING ---
    lea rdi, [msg_boot]
    mov rsi, len_boot
    call FIRE_LOG_STRIKE

    ; --- 2. OPEN THE BLUEPRINT (fire-term.ini) ---
    mov rax, 2              ; sys_open
    mov rdi, ini_path
    mov rsi, 0              ; O_RDONLY
    syscall
    test rax, rax
    js .error_exit
    mov r12, rax            ; Save FD

    ; --- 3. READ INI INTO BUFFER ---
    mov rax, 0              ; sys_read
    mov rdi, r12
    mov rsi, ini_buffer
    mov rdx, 4096
    syscall
    
    ; --- 4. LOCATE [AVIS] SECTOR ---
    lea rdi, [msg_loop]
    mov rsi, len_loop
    call FIRE_LOG_STRIKE

    lea rsi, [ini_buffer]
.find_avis:
    ; (Loop logic to scan for "[AVIS]" marker)
    ; For the demo: assuming found, skip to !#bgin
    
.find_bgin:
    ; (Loop logic to scan for "!#bgin")

    ; --- 5. THE STRIKE LOOP ---
.strike_cycle:
    ; Parse "STRIKE: target.exe"
    ; If "!#FIRE-END" reached, jmp .seal_engine

    ; FORK & EXECVE (System Handoff)
    mov rax, 57             ; sys_fork
    syscall
    test rax, rax
    jnz .parent_wait

    ; Child: Execute current STRIKE target
    mov rax, 59             ; sys_execve
    lea rdi, [cmd_buffer]   ; Extracted binary path
    xor rsi, rsi            ; No argv
    xor rdx, rdx            ; No envp
    syscall
    jmp .error_exit

.parent_wait:
    mov rax, 61             ; sys_wait4
    mov rdi, -1
    xor rsi, rsi
    xor rdx, rdx
    xor r10, r10
    syscall
    jmp .strike_cycle

.seal_engine:
    mov rax, 3              ; sys_close
    mov rdi, r12
    syscall

    mov rax, 60             ; sys_exit
    xor rdi, rdi
    syscall

.error_exit:
    mov rax, 60
    mov rdi, 1
    syscall
