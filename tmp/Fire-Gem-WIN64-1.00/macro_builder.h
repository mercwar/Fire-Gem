// macro_builder.h
#pragma once
#include <windows.h>
#include "fire_gem.h"
#include "json_loader.h"

BOOL FG_BuildMacro(FG_MACRO *macro, const char *workingDir, HWND log);
