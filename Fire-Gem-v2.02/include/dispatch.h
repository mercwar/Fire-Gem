// AIFVS-ARTIFACT
// dispatch.h — FireGem response dispatcher interface

#ifndef DISPATCH_H
#define DISPATCH_H

#ifdef __cplusplus
extern "C" {
#endif

// Dispatch generated response buffer to implant hooks
void FireGem_DispatchResponse(const char *outbuf);

#ifdef __cplusplus
}
#endif

#endif // DISPATCH_H
