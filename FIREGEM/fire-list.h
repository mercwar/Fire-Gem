#pragma once

#include <windows.h>
#include <commctrl.h>

#ifdef __cplusplus
extern "C" {
#endif

void Fire_PopulateDrives(HWND hTree);
void Fire_PopulateFolder(HWND hTree, HTREEITEM hItem, const wchar_t* path);
void Fire_AddDummyChild(HWND hTree, HTREEITEM hItem);
void Fire_BuildPathFromItem(HWND hTree, HTREEITEM hItem, wchar_t* out, int max);
void Fire_BuildFullPath(HWND hTree, HTREEITEM hItem, wchar_t* out, int max);

#ifdef __cplusplus
}
#endif
