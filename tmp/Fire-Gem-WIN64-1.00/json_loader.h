// json_loader.h
#pragma once
#include <windows.h>
#include "fire_gem.h"

BOOL FG_LoadJson(const char *fullPath, FG_MACRO *out);
BOOL FG_ExtractScriptFromJson(FG_MACRO *macro);
BOOL FG_ReadShebang(const char *scriptPath, char *outShebang);
