// macro_runner.c
#include <windows.h>
#include <stdio.h>
#include "fire_gem.h"
#include "fg_log.h"

// Unified execution engine
void FG_RunSingleCommand(HWND hEditLog, const char *workingDir, const char *cmd)
{
    char fullCmd[2048];

    snprintf(
        fullCmd,
        sizeof(fullCmd),
        "C:\\msys64\\msys2_shell.cmd -ucrt64 -defterm -no-start -here -c \"%s\"",
        cmd
    );

    FG_Log(hEditLog, "[run] ShellExecute: ");
    FG_Log(hEditLog, fullCmd);
    FG_Log(hEditLog, "\r\n");

    ShellExecuteA(
        NULL,
        "open",
        "C:\\Windows\\System32\\cmd.exe",
        fullCmd,
        workingDir,
        SW_HIDE
    );
}

// Run JSON macro
void FG_RunBuiltMacro(HWND hEditLog, FG_JSON_MACRO *macro, const char *workingDir)
{
    FG_Log(hEditLog, "[macro] Starting JSON macro...\r\n");

    if (macro->cmdBash[0])
        FG_RunSingleCommand(hEditLog, workingDir, macro->cmdBash);

    if (macro->fileSh[0])
        FG_RunSingleCommand(hEditLog, workingDir, macro->fileSh);

    if (macro->fileBash[0])
        FG_RunSingleCommand(hEditLog, workingDir, macro->fileBash);

    if (macro->fileBat[0])
        FG_RunSingleCommand(hEditLog, workingDir, macro->fileBat);

    if (macro->fileCmd[0])
        FG_RunSingleCommand(hEditLog, workingDir, macro->fileCmd);

    if (macro->cmdInet[0])
        FG_RunSingleCommand(hEditLog, workingDir, macro->cmdInet);

    if (macro->cmdExec[0])
        FG_RunSingleCommand(hEditLog, workingDir, macro->cmdExec);

    FG_Log(hEditLog, "[macro] JSON macro complete.\r\n");
}
