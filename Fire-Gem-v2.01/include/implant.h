#ifndef IMPLANT_H
#define IMPLANT_H

#include <windows.h>

/**
 * Displays a standard Win32 information dialog box.
 * @param message The text content to display inside the box.
 * @param title The caption header text for the dialog window.
 * @return Returns the integer code representing the user's action (e.g., IDOK).
 */
int DisplayStatusMessage(const char *message, const char *title);

#endif // IMPLANT_H
