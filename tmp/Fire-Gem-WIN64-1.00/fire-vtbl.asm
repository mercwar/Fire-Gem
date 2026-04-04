; fire-vtbl.asm
; Fire-Gem vtable for a fully installable Android emulator pipeline
; Win64, data-only module

SECTION .data

; -------------------------
; Core / filesystem commands
; -------------------------
Cmd_cd              db "cd",0
Cmd_ls              db "ls",0
Cmd_mkdir           db "mkdir",0
Cmd_rm              db "rm",0
Cmd_cp              db "cp",0
Cmd_mv              db "mv",0
Cmd_cat             db "cat",0

; -------------------------
; Toolchain / build commands
; -------------------------
Cmd_gcc             db "gcc",0
Cmd_as              db "as",0
Cmd_ld              db "ld",0
Cmd_compile         db "compile",0
Cmd_link            db "link",0

; -------------------------
; Shell / host bridge
; -------------------------
Cmd_sh              db "sh",0
Cmd_cmdexe          db "cmdexe",0

; -------------------------
; Dependency / prerequisite checks
; -------------------------
Cmd_deps_check      db "deps.check",0          ; check UCRT/VC++/QEMU presence
Cmd_deps_report     db "deps.report",0         ; print detailed status

; -------------------------
; Android install pipeline
; -------------------------
Cmd_android_check   db "android.check",0       ; verify all Android resources present
Cmd_android_prepare db "android.prepare",0     ; create dirs, copy base files
Cmd_android_config  db "android.config",0      ; write configs/INIs from templates
Cmd_android_install db "android.install",0     ; assemble a runnable emulator tree
Cmd_android_run     db "android.run",0         ; launch emulator
Cmd_android_clean   db "android.clean",0       ; remove build artifacts

; -------------------------
; Android engine / images
; -------------------------
Cmd_android_qemu    db "android.qemu",0        ; engine-level control
Cmd_android_sysimg  db "android.sysimg",0      ; system.img management
Cmd_android_userdata db "android.userdata",0   ; userdata.img management

; -------------------------
; Android tools
; -------------------------
Cmd_android_adb     db "android.adb",0
Cmd_android_logcat  db "android.logcat",0

; -------------------------
; Fire-Gem internal control
; -------------------------
Cmd_fg_scan         db "fg.scan",0             ; rescan ini/ directory
Cmd_fg_reload       db "fg.reload",0           ; reload configs/vtable
Cmd_fg_prompt       db "fg.prompt",0           ; show command menu
Cmd_fg_exit         db "fg.exit",0             ; quit

; -------------------------
; Handler externs
; -------------------------
extern FG_CMD_CD
extern FG_CMD_LS
extern FG_CMD_MKDIR
extern FG_CMD_RM
extern FG_CMD_CP
extern FG_CMD_MV
extern FG_CMD_CAT

extern FG_CMD_GCC
extern FG_CMD_AS
extern FG_CMD_LD
extern FG_CMD_COMPILE
extern FG_CMD_LINK

extern FG_CMD_SH
extern FG_CMD_CMDEXE

extern FG_CMD_DEPS_CHECK
extern FG_CMD_DEPS_REPORT

extern FG_CMD_ANDROID_CHECK
extern FG_CMD_ANDROID_PREPARE
extern FG_CMD_ANDROID_CONFIG
extern FG_CMD_ANDROID_INSTALL
extern FG_CMD_ANDROID_RUN
extern FG_CMD_ANDROID_CLEAN

extern FG_CMD_ANDROID_QEMU
extern FG_CMD_ANDROID_SYSIMG
extern FG_CMD_ANDROID_USERDATA

extern FG_CMD_ANDROID_ADB
extern FG_CMD_ANDROID_LOGCAT

extern FG_CMD_FG_SCAN
extern FG_CMD_FG_RELOAD
extern FG_CMD_FG_PROMPT
extern FG_CMD_FG_EXIT

; -------------------------
; VTABLE
; name_ptr, handler_ptr
; -------------------------
FireGemVTable:
    dq Cmd_cd,              FG_CMD_CD
    dq Cmd_ls,              FG_CMD_LS
    dq Cmd_mkdir,           FG_CMD_MKDIR
    dq Cmd_rm,              FG_CMD_RM
    dq Cmd_cp,              FG_CMD_CP
    dq Cmd_mv,              FG_CMD_MV
    dq Cmd_cat,             FG_CMD_CAT

    dq Cmd_gcc,             FG_CMD_GCC
    dq Cmd_as,              FG_CMD_AS
    dq Cmd_ld,              FG_CMD_LD
    dq Cmd_compile,         FG_CMD_COMPILE
    dq Cmd_link,            FG_CMD_LINK

    dq Cmd_sh,              FG_CMD_SH
    dq Cmd_cmdexe,          FG_CMD_CMDEXE

    dq Cmd_deps_check,      FG_CMD_DEPS_CHECK
    dq Cmd_deps_report,     FG_CMD_DEPS_REPORT

    dq Cmd_android_check,   FG_CMD_ANDROID_CHECK
    dq Cmd_android_prepare, FG_CMD_ANDROID_PREPARE
    dq Cmd_android_config,  FG_CMD_ANDROID_CONFIG
    dq Cmd_android_install, FG_CMD_ANDROID_INSTALL
    dq Cmd_android_run,     FG_CMD_ANDROID_RUN
    dq Cmd_android_clean,   FG_CMD_ANDROID_CLEAN

    dq Cmd_android_qemu,    FG_CMD_ANDROID_QEMU
    dq Cmd_android_sysimg,  FG_CMD_ANDROID_SYSIMG
    dq Cmd_android_userdata,FG_CMD_ANDROID_USERDATA

    dq Cmd_android_adb,     FG_CMD_ANDROID_ADB
    dq Cmd_android_logcat,  FG_CMD_ANDROID_LOGCAT

    dq Cmd_fg_scan,         FG_CMD_FG_SCAN
    dq Cmd_fg_reload,       FG_CMD_FG_RELOAD
    dq Cmd_fg_prompt,       FG_CMD_FG_PROMPT
    dq Cmd_fg_exit,         FG_CMD_FG_EXIT

FireGemVTable_Count equ 34
