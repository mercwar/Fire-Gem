// AIFVS-ARTIFACT
// implant.h — FireGem system implant interface

#ifndef IMPLANT_H
#define IMPLANT_H

#ifdef __cplusplus
extern "C" {
#endif

// Display a status popup (basic implant signal)
int DisplayStatusMessage(const char *message, const char *title);

// Core implant hook — invoked when LLM stream hits trigger
void FireGem_InterceptSignal(const char *signal);

#ifdef __cplusplus
}
#endif

#endif // IMPLANT_H
