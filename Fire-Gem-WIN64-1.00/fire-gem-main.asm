; fire-gem-main.asm
; Entry point and high-level orchestration

default rel
extern FG_InitWindow
extern FG_MainLoop
extern ExitProcess

section .text
global main

main:
FG_InitCrashLog:
    ; open firegem_startup.log in write mode
    ; if it fails, try C:\temp\firegem_startup.log
    ; write "FireGem starting..."
    ; return

    ; initialize Fire-Gem window and controls
    call FG_InitWindow

    ; enter main UI loop (message loop / event loop)
    call FG_MainLoop

    ; exit process
    mov ecx, 0
    call ExitProcess
