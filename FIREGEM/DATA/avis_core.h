/* -------------------------------------------------------------------------
   AVIS UNIFIED INTERPRETER - CORE ARCHITECTURE
   PROJECT: AVIS-CMD-ROBOT-GGUF (v1.0.0)
   OWNER: JOSEPH MICHAEL CATALANO (CVBGOD / DEMONIZER)
   FILE: avis_core.h
   NEURAL_PATH: C:\Apache24\htdocs\FIRE-GEM\LLM\Qwen2.5-Coder-1.5B-Instruct.Q8_0.gguf
   LAW: HIGH-SHINE / LOW-LEVEL / PURE C / XML-MEMORY
   ------------------------------------------------------------------------- */

#ifndef AVIS_CORE_H
#define AVIS_CORE_H

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>
#include <string.h>

// UI Handles for the Split Terminal
extern HWND hLeftEdit_CMD;   // Real cmd.exe output
extern HWND hRightEdit_BOT;  // Assistant / Help Guide
extern HWND hInputLine;      // User Command Input

// Function Protocols
void AVIS_LogToBot(const char* text);
void AVIS_SendToCmd(const char* command);
void AVIS_ProcessNeuralIntent(const char* input);

#endif