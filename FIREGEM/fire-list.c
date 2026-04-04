#include <windows.h>
#include <commctrl.h>
#include <wchar.h>

#include "fire-list.h"

// Local helper
static void TreeView_GetItemTextW(HWND hTree, HTREEITEM hItem, wchar_t* buf, int max)
{
    TVITEMW tvi;
    ZeroMemory(&tvi, sizeof(tvi));
    tvi.mask = TVIF_TEXT;
    tvi.hItem = hItem;
    tvi.pszText = buf;
    tvi.cchTextMax = max;
    TreeView_GetItem(hTree, &tvi);
}

void Fire_AddDummyChild(HWND hTree, HTREEITEM hItem)
{
    TVINSERTSTRUCTW tvis;
    ZeroMemory(&tvis, sizeof(tvis));
    tvis.hParent      = hItem;
    tvis.hInsertAfter = TVI_LAST;
    tvis.item.mask    = TVIF_TEXT;
    tvis.item.pszText = L"...";

    TreeView_InsertItem(hTree, &tvis);   // <-- GENERIC MACRO
}

void Fire_PopulateDrives(HWND hTree)
{
    DWORD mask = GetLogicalDrives();

    for (int i = 0; i < 26; ++i)
    {
        if (mask & (1 << i))
        {
            wchar_t drive[8];
            swprintf(drive, 8, L"%c:\\", 'A' + i);

            TVINSERTSTRUCTW tvis;
            ZeroMemory(&tvis, sizeof(tvis));
            tvis.hParent      = TVI_ROOT;
            tvis.hInsertAfter = TVI_LAST;
            tvis.item.mask    = TVIF_TEXT;
            tvis.item.pszText = drive;

            HTREEITEM hDrive = TreeView_InsertItem(hTree, &tvis);  // <-- FIXED
            if (hDrive)
                Fire_AddDummyChild(hTree, hDrive);
        }
    }
}

void Fire_PopulateFolder(HWND hTree, HTREEITEM hItem, const wchar_t* path)
{
    wchar_t search[MAX_PATH];
    swprintf(search, MAX_PATH, L"%ls\\*", path);

    WIN32_FIND_DATAW fd;
    HANDLE hFind = FindFirstFileW(search, &fd);
    if (hFind == INVALID_HANDLE_VALUE)
        return;

    do {
        // -----------------------------
        // 1. FOLDERS
        // -----------------------------
        if (fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
        {
            if (!wcscmp(fd.cFileName, L".") ||
                !wcscmp(fd.cFileName, L".."))
                continue;

            TVINSERTSTRUCTW tvis = {0};
            tvis.hParent      = hItem;
            tvis.hInsertAfter = TVI_LAST;
            tvis.item.mask    = TVIF_TEXT;
            tvis.item.pszText = fd.cFileName;

            HTREEITEM hNew = TreeView_InsertItem(hTree, &tvis);
            if (hNew)
                Fire_AddDummyChild(hTree, hNew);
        }
        else
        {
            // -----------------------------
            // 2. FILES
            // -----------------------------
            TVINSERTSTRUCTW tvis = {0};
            tvis.hParent      = hItem;
            tvis.hInsertAfter = TVI_LAST;
            tvis.item.mask    = TVIF_TEXT;
            tvis.item.pszText = fd.cFileName;

            TreeView_InsertItem(hTree, &tvis);
        }

    } while (FindNextFileW(hFind, &fd));

    FindClose(hFind);
}

void Fire_BuildPathFromItem(HWND hTree, HTREEITEM hItem, wchar_t* out, int max)
{
    wchar_t segments[32][MAX_PATH];
    int count = 0;

    HTREEITEM cur = hItem;
    while (cur && count < 32) {
        wchar_t buf[MAX_PATH];
        TreeView_GetItemTextW(hTree, cur, buf, MAX_PATH);

        if (wcscmp(buf, L"...") != 0) {
            wcscpy(segments[count], buf);
            ++count;
        }
        cur = TreeView_GetParent(hTree, cur);
    }

    out[0] = L'\0';

    // walk backwards: drive first, then folders
    for (int i = count - 1; i >= 0; --i) {
        if (i == count - 1) {
            // drive already has trailing backslash, e.g. "C:\"
            wcsncat(out, segments[i], max - wcslen(out) - 1);
        } else {
            wcsncat(out, L"\\", max - wcslen(out) - 1);
            wcsncat(out, segments[i], max - wcslen(out) - 1);
        }
    }
}
void Fire_BuildFullPath(HWND hTree, HTREEITEM hItem, wchar_t* out, int max)
{
    wchar_t parts[64][MAX_PATH];
    int count = 0;

    HTREEITEM cur = hItem;

    while (cur && count < 64)
    {
        wchar_t buf[MAX_PATH];
        TVITEMW tvi = {0};
        tvi.mask = TVIF_TEXT;
        tvi.hItem = cur;
        tvi.pszText = buf;
        tvi.cchTextMax = MAX_PATH;
        TreeView_GetItem(hTree, &tvi);

        if (wcscmp(buf, L"...") != 0)
            wcscpy(parts[count++], buf);

        cur = TreeView_GetParent(hTree, cur);
    }

    out[0] = 0;

    for (int i = count - 1; i >= 0; --i)
    {
        if (i == count - 1)
        {
            wcsncat(out, parts[i], max - wcslen(out) - 1);
        }
        else
        {
            wcsncat(out, L"\\", max - wcslen(out) - 1);
            wcsncat(out, parts[i], max - wcslen(out) - 1);
        }
    }
}
