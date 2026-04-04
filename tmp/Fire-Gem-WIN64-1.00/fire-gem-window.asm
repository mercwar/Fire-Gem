; fire-gem-window.asm
; Window creation, buttons, dropdown, log box, and event dispatch

default rel

extern FG_LoadIni_Click
extern FG_LoadJson_Click
extern FG_Build_Click
extern FG_Run_Click

section .data
; handles for controls (to be filled by your WinAPI code)
FG_hMainWindow      dq 0
FG_hBtnLoadIni      dq 0
FG_hCmbJsonSelect   dq 0
FG_hBtnLoadJson     dq 0
FG_hBtnBuild        dq 0
FG_hBtnRun          dq 0
FG_hEditLog         dq 0

section .text
global FG_InitWindow
global FG_MainLoop
global FG_LogString

FG_InitWindow:
    ; TODO: Create main window, controls, and store handles above.
    ; - Create main window
    ; - Create "Load INI..." button
    ; - Create JSON dropdown
    ; - Create "Load JSON" button
    ; - Create "Build" button
    ; - Create "Run Program" button
    ; - Create multiline log edit control
    ret

FG_MainLoop:
    ; TODO: Standard Win32 message loop or your own event loop.
    ; Dispatch button clicks to:
    ;   FG_LoadIni_Click
    ;   FG_LoadJson_Click
    ;   FG_Build_Click
    ;   FG_Run_Click
    ret

FG_LogString:
    ; RCX = pointer to zero-terminated string
    ; TODO: Append string to FG_hEditLog (multiline edit) or your log control.
    ret
