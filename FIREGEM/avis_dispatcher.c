/* -------------------------------------------------------------------------
   AVIS DISPATCHER - NEURAL INTENT ROUTER
   FILE: avis_dispatcher.c
   ------------------------------------------------------------------------- */

#include "INCLUDE/avis_core.h"

// Original ANSI wrapper for internal logging
void AVIS_LogToBot(const char* text) {
    int wlen = MultiByteToWideChar(CP_ACP, 0, text, -1, NULL, 0);
    wchar_t* wbuf = (wchar_t*)malloc(wlen * sizeof(wchar_t));
    MultiByteToWideChar(CP_ACP, 0, text, -1, wbuf, wlen);

    int len = GetWindowTextLengthW(hRightEdit_BOT);
    SendMessageW(hRightEdit_BOT, EM_SETSEL, (WPARAM)len, (LPARAM)len);
    SendMessageW(hRightEdit_BOT, EM_REPLACESEL, 0, (LPARAM)wbuf);
    SendMessageW(hRightEdit_BOT, EM_REPLACESEL, 0, (LPARAM)L"\r\n");
    free(wbuf);
}

// Logic for the 'ASK ROBOT' button
#include "INCLUDE/avis_core.h"

void AVIS_ProcessNeuralIntentW(const wchar_t* input) {
    // 1. Log the user input to the Right Pane
    int len = GetWindowTextLengthW(hRightEdit_BOT);
    SendMessageW(hRightEdit_BOT, EM_SETSEL, (WPARAM)len, (LPARAM)len);
    SendMessageW(hRightEdit_BOT, EM_REPLACESEL, 0, (LPARAM)L"USER > ");
    SendMessageW(hRightEdit_BOT, EM_REPLACESEL, 0, (LPARAM)input);
    SendMessageW(hRightEdit_BOT, EM_REPLACESEL, 0, (LPARAM)L"\r\n");

    // 2. Pass to the Llama Engine
    AVIS_GenerateRobotResponse(input);
}