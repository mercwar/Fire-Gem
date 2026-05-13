/* FILE: constellation_linker.h */
/* PATH: /Constellation/constellation_linker.h */

/* ------------------------------------------------------------
   AVIS.HEADER
   ROLE: CONSTELLATION_LINKER_HEADER
   PURPOSE: Header for the Constellation Linker. Defines structs,
            constants, and prototypes used to merge compiled
            Constellation versions into a unified intelligence
            model.
   AUTHOR: Demon
   NOTES: This is the FOURTH HEADER in the Constellation chain.
   ------------------------------------------------------------ */

#ifndef CONSTELLATION_LINKER_H
#define CONSTELLATION_LINKER_H

#define MAX_PATH 1024
#define MAX_BINARIES 256

typedef struct {
    char path[MAX_PATH];
    char name[MAX_PATH];
} BinaryEntry;

int is_binary(const char *name);
int scan_binaries(const char *path,
                  BinaryEntry bins[],
                  int *count);
void link_binaries(BinaryEntry bins[],
                   int count,
                   const char *output);

#endif
