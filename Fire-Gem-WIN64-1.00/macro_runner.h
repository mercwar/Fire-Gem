// macro_runner.h
#pragma once
#include <windows.h>
#include "fire_gem.h"

void FG_RunBuiltMacro(HWND hEditLog, FG_MACRO *macro, const char *workingDir);
void FG_RunSingleCommand(HWND hEditLog, const char *workingDir, const char *cmd);
void WinPathToPosix(const char *win, char *posix);
static void RunHiddenProcess(HWND hEditLog, const char *command);