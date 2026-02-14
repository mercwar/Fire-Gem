; =============================================================================
;  AVIS VERSION 1 VAULT ARCHITECT
;  FILE: fire-end.asm
;  PURPOSE: Create VERSION 1/fire-log/ and migrate log via sys_rename
; =============================================================================

section .data
    log_dir  db "VERSION 1/fire-log", 0
    old_name db "VERSION 1/fire-gem.log", 0
    ; Final path template: VERSION 1/fire-log/fire-log-[HEX].avis
    prefix   db "VERSION 1/fire-log/fire-log-", 0
    ext      db ".avis", 0
    msg_sync db "[SYNC] VERSION 1 Vault Sealed. HAHA!", 0xa

section .bss
    new_name resb 128
    tv       resq 2      ; timeval struct: [seconds, microseconds]

section .text
    global _start
    extern FIRE_LOG_STRIKE

_start:
    ; --- 1. CREATE THE VERSION 1 VAULT ---
    mov rax, 83         ; sys_mkdir
    mov rdi, log_dir
    mov rsi, 0755o
    syscall             ; EEXIST is ignored by kernel

    ; --- 2. FINAL LOG ENTRY VIA MODULAR OBJECT ---
    lea rdi, [msg_sync]
    mov rsi, 37
    call FIRE_LOG_STRIKE

    ; --- 3. THE TIME STRIKE (sys_gettimeofday) ---
    mov rax, 96         ; sys_gettimeofday
    lea rdi, [tv]
    xor rsi, rsi
    syscall

    ; --- 4. CONSTRUCT DYNAMIC PATH ---
    lea rdi, [new_name]
    lea rsi, [prefix]
.copy_pre:
    lodsb
    test al, al
    jz .load_time
    stosb
    jmp .copy_pre

.load_time:
    mov rax, [tv]       ; Load actual seconds from kernel
    mov rcx, 16         ; Full 64-bit Hex spread
.hex_loop:
    rol rax, 4
    mov rbx, rax
    and rbx, 0x0F
    add bl, 0x30
    cmp bl, 0x39
    jle .store
    add bl, 7           ; Adjust for 'A'-'F'
.store:
    mov [rdi], bl
    inc rdi
    loop .hex_loop

    lea rsi, [ext]
.copy_ext:
    lodsb
    test al, al
    jz .do_rename
    stosb
    jmp .copy_ext

.do_rename:
    mov byte [rdi], 0

    ; --- 5. HARDWARE MIGRATION ---
    mov rax, 82         ; sys_rename
    mov rdi, old_name
    lea rsi, [new_name]
    syscall

    ; --- 6. EXIT ---
    mov rax, 60
    xor rdi, rdi
    syscall
