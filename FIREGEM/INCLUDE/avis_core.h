#ifndef AVIS_CORE_H
#define AVIS_CORE_H

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <commctrl.h>

#define MAX_BUFFER 4096

// BRIDGING C AND C++ SECTORS
#ifdef __cplusplus
extern "C" {
#endif

// UI SECTOR HANDLES
extern HWND hLeftEdit_CMD, hRightEdit_BOT;
extern HWND hInput_CMD, hInput_BOT; 

// ENGINE PROTOS
void AVIS_InitCmdPipe();
void AVIS_SendToCmdW(const wchar_t* command);
void AVIS_ProcessNeuralIntentW(const wchar_t* input);
DWORD WINAPI AVIS_PipeReaderThread(LPVOID lpParam);

// NEURAL SECTOR BRIDGES
void AVIS_InitNeuralSector();
void AVIS_GenerateRobotResponse(const wchar_t* input);
void AVIS_LogToBot(const char* text);



// Add these to your existing header:
void AVIS_RefreshModelList(HWND hCombo);
void AVIS_SwitchNeuralModel(const wchar_t* modelFilename);

// Ensure your global handle is visible across files
extern HWND hModelDrop; 
#ifdef __cplusplus
}
#endif

#endif

