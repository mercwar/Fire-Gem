// ini_loader.h
#pragma once
#include <windows.h>
#include "fire_gem.h"

BOOL FG_OpenIniDialog(HWND hwnd, char *outPath);
BOOL FG_ParseIni(const char *iniPath, FG_INI *out);
void FG_FillJsonDropdown(HWND hwndCombo, const char *dir);
