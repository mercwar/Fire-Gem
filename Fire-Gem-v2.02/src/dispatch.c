// AIFVS-ARTIFACT
// dispatch.c — FireGem response dispatcher implementation

#include "dispatch.h"
#include "implant.h"
#include <string.h>

void FireGem_DispatchResponse(const char *outbuf) {
    if (!outbuf) return;

    // 🔍 Intercept generation streams for specified tool triggers
    if (strstr(outbuf, "[ACTION: RunModuleCheck]") != NULL) {
        DisplayStatusMessage(
            "FireGem Matrix Intercept: Execution module check invoked by LLM node core.",
            "System Signal Hook"
        );
    }

    // 🔍 FireGem API capability: <firebox>MESSAGE</firebox>
    const char *start = strstr(outbuf, "<firebox>");
    if (start) {
        start += 9; // skip "<firebox>"
        const char *end = strstr(start, "</firebox>");
        if (end) {
            char msg[512] = {0};
            size_t len = (size_t)(end - start);
            if (len < sizeof(msg)) {
                memcpy(msg, start, len);
                msg[len] = '\0';
                DisplayStatusMessage(msg, "FireGem API Trigger");
            }
        }
    }

    // 🔮 Future expansion: add more implants here
    // e.g. <fireapi action="TelemetryDump">...</fireapi>
}
