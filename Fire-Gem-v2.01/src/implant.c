#include "implant.h"

int DisplayStatusMessage(const char *message, const char *title) {
    // Renders a standard modal warning/information popup box bound to the active desktop view
    return MessageBoxA(
        NULL,                  // Owner window handle (NULL balances it as a top-level desktop dialog)
        message,               // Internal message string text
        title,                 // Window frame caption header
        MB_OK | MB_ICONINFORMATION | MB_TOPMOST // Configuration matrix flags
    );
}
