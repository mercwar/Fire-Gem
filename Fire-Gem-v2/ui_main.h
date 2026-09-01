#ifndef UI_MAIN_H
#define UI_MAIN_H

#include <windows.h>

extern HWND hList, hConsole, hInput, hButton, hSendBtn;

void LoadAnyJson(const char *filename);
LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);

#endif
