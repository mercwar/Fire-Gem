#include "INCLUDE/avis_core.h"

HANDLE hCmdInWrite, hCmdOutRead;

// WIDE VERSION FOR THE SEND BUTTON
void AVIS_SendToCmdW(const wchar_t* command) {
    DWORD written;
    char ansiBuf[1024];
    // Convert to ANSI because CMD.EXE doesn't speak Unicode by default
    WideCharToMultiByte(CP_ACP, 0, command, -1, ansiBuf, sizeof(ansiBuf), NULL, NULL);
    strcat(ansiBuf, "\n");
    
    if (hCmdInWrite) {
        WriteFile(hCmdInWrite, ansiBuf, (DWORD)strlen(ansiBuf), &written, NULL);
    }
}

void AVIS_InitCmdPipe() {
    SECURITY_ATTRIBUTES sa = {sizeof(sa), NULL, TRUE};
    HANDLE hRead, hWrite;
    
    CreatePipe(&hCmdOutRead, &hWrite, &sa, 0);
    SetHandleInformation(hCmdOutRead, HANDLE_FLAG_INHERIT, 0);
    CreatePipe(&hRead, &hCmdInWrite, &sa, 0);
    SetHandleInformation(hCmdInWrite, HANDLE_FLAG_INHERIT, 0);

    STARTUPINFOW si = {sizeof(si)};
    si.dwFlags = STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW;
    si.hStdOutput = hWrite;
    si.hStdError = hWrite;
    si.hStdInput = hRead;
    si.wShowWindow = SW_HIDE;

    PROCESS_INFORMATION pi = {0};
    // Launching the hidden shell
    CreateProcessW(L"C:\\Windows\\System32\\cmd.exe", NULL, NULL, NULL, TRUE, 0, NULL, NULL, &si, &pi);
    CreateThread(NULL, 0, AVIS_PipeReaderThread, NULL, 0, NULL);
}

DWORD WINAPI AVIS_PipeReaderThread(LPVOID lpParam) {
    char buffer[MAX_BUFFER];
    DWORD read;
    while (ReadFile(hCmdOutRead, buffer, sizeof(buffer) - 1, &read, NULL) && read > 0) {
        buffer[read] = '\0';
        int wlen = MultiByteToWideChar(CP_ACP, 0, buffer, -1, NULL, 0);
        wchar_t* wbuf = (wchar_t*)malloc(wlen * sizeof(wchar_t));
        MultiByteToWideChar(CP_ACP, 0, buffer, -1, wbuf, wlen);

        int len = GetWindowTextLengthW(hLeftEdit_CMD);
        SendMessageW(hLeftEdit_CMD, EM_SETSEL, (WPARAM)len, (LPARAM)len);
        SendMessageW(hLeftEdit_CMD, EM_REPLACESEL, 0, (LPARAM)wbuf);
        free(wbuf);
    }
    return 0;
}