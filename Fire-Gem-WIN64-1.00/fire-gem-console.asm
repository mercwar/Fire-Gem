;===========================================================
; AVIS FILE IDENTITY BLOCK
;===========================================================
; CY_FILENAME: fire-gem-console.asm
; CY_NAME: FIRE_GEM_CONSOLE_ASM
; CY_TYPE: ASM_MODULE
; CY_ROLE: WIN64_CONSOLE_IO
; CY_SUBSYS: FIRE_GEM
; CY_VERSION: 01.00
; CY_GUID: {F000-E111-D222-C333-B444A555F666}
; CY_BUILD: MANUAL
; CY_NOTES: BASIC PRINT/READ FOR FIRE-GEM TERMINAL.
;===========================================================

default rel
extern  GetStdHandle
extern  WriteConsoleA
extern  ReadConsoleA

SECTION .data
FG_NewLine      db 13,10,0
FG_InputBuffer  times 512 db 0

SECTION .text
global FG_PrintString
global FG_ReadLine
global FG_StrLen

; RCX = pointer to null-terminated string
FG_PrintString:
    push    rbx
    mov     rbx, rcx

    mov     ecx, -11
    call    GetStdHandle

    mov     rcx, rax
    mov     rdx, rbx
    mov     r8,  rbx
    call    FG_StrLen
    mov     r8,  rax
    mov     r9,  0

    sub     rsp, 32
    call    WriteConsoleA
    add     rsp, 32

    pop     rbx
    ret

; RCX = buffer pointer
FG_ReadLine:
    push    rbx
    mov     rbx, rcx

    mov     ecx, -10
    call    GetStdHandle

    mov     rcx, rax
    mov     rdx, rbx
    mov     r8,  512
    mov     r9,  0

    sub     rsp, 32
    call    ReadConsoleA
    add     rsp, 32

    ; zero-terminate at CR
    mov     rcx, rbx
.scan:
    cmp     byte [rcx], 13
    je      .zero
    cmp     byte [rcx], 0
    je      .done
    inc     rcx
    jmp     .scan
.zero:
    mov     byte [rcx], 0
.done:
    pop     rbx
    ret

; RDX = string
FG_StrLen:
    xor     rax, rax
.len:
    cmp     byte [rdx+rax], 0
    je      .end
    inc     rax
    jmp     .len
.end:
    ret
