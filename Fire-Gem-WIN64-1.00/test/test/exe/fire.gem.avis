; fire-gem.asm
; Correct Win64 GUI entry point using wWinMain

default rel

extern  GetModuleHandleW
extern  RegisterClassExW
extern  CreateWindowExW
extern  ShowWindow
extern  UpdateWindow
extern  GetMessageW
extern  TranslateMessage
extern  DispatchMessageW
extern  DefWindowProcW
extern  PostQuitMessage

SECTION .data

WC_NAME     dw 'F','i','r','e','G','e','m',0
WIN_TITLE   dw 'F','i','r','e','-','G','e','m',0

BTN_LOAD_INI_TXT  dw 'L','o','a','d',' ','I','N','I','.',0
BTN_LOAD_JSON_TXT dw 'L','o','a','d',' ','J','S','O','N',0
BTN_BUILD_TXT     dw 'B','u','i','l','d',0
BTN_RUN_TXT       dw 'R','u','n',' ','P','r','o','g','r','a','m',0

; control IDs
IDC_BTN_LOAD_INI    equ 1001
IDC_CMB_JSON        equ 1002
IDC_BTN_LOAD_JSON   equ 1003
IDC_BTN_BUILD       equ 1004
IDC_BTN_RUN         equ 1005
IDC_EDIT_LOG        equ 1006

SECTION .bss
hInstance   resq 1
msg         resb 48
wc          resb 80

SECTION .text
global wWinMain
global WndProc

; ---------------------------------------------------------
; wWinMain — REQUIRED for -mwindows
; ---------------------------------------------------------
wWinMain:
    ; hInstance
    xor     rcx, rcx
    call    GetModuleHandleW
    mov     [hInstance], rax

    ; register class
    lea     rcx, [rel wc]
    lea     rdx, [rel WC_NAME]
    call    InitWindowClass

    ; create window
    mov     rcx, 0
    lea     rdx, [rel WC_NAME]
    lea     r8,  [rel WIN_TITLE]
    mov     r9d, 0x00CF0000        ; WS_OVERLAPPEDWINDOW
    sub     rsp, 32
    mov     qword [rsp+0], 100     ; x
    mov     qword [rsp+8], 100     ; y
    mov     qword [rsp+16], 800    ; w
    mov     qword [rsp+24], 600    ; h
    push    0
    push    0
    push    [hInstance]
    push    0
    call    CreateWindowExW
    add     rsp, 32+32

    ; show window
    mov     rcx, rax
    mov     rdx, 5
    call    ShowWindow
    mov     rcx, rax
    call    UpdateWindow

    ; message loop
.msg_loop:
    lea     rcx, [rel msg]
    xor     rdx, rdx
    xor     r8,  r8
    xor     r9,  r9
    call    GetMessageW
    test    eax, eax
    jz      .exit
    lea     rcx, [rel msg]
    call    TranslateMessage
    lea     rcx, [rel msg]
    call    DispatchMessageW
    jmp     .msg_loop

.exit:
    xor     eax, eax
    ret

; ---------------------------------------------------------
; InitWindowClass — registers WNDCLASSEXW
; ---------------------------------------------------------
InitWindowClass:
    ; zero struct
    mov     rdi, rcx
    mov     ecx, 80/8
    xor     rax, rax
    rep stosq

    mov     dword [wc+0], 80            ; cbSize
    mov     dword [wc+4], 3             ; CS_HREDRAW|CS_VREDRAW
    lea     rax, [rel WndProc]
    mov     [wc+8], rax                 ; lpfnWndProc
    mov     rax, [hInstance]
    mov     [wc+24], rax                ; hInstance
    mov     [wc+64], rdx                ; lpszClassName

    lea     rcx, [rel wc]
    call    RegisterClassExW
    ret

; ---------------------------------------------------------
; WndProc — creates controls on WM_CREATE
; ---------------------------------------------------------
WndProc:
    cmp     edx, 1          ; WM_CREATE
    je      .on_create
    cmp     edx, 2          ; WM_DESTROY
    je      .on_destroy

.def:
    sub     rsp, 32
    call    DefWindowProcW
    add     rsp, 32
    ret

.on_destroy:
    sub     rsp, 32
    xor     rcx, rcx
    call    PostQuitMessage
    add     rsp, 32
    xor     eax, eax
    ret

.on_create:
    ; TODO: Create buttons, combobox, edit control
    xor     eax, eax
    ret
