/* FILE: constellation.h */
/* PATH: /Constellation/constellation.h */

/* ------------------------------------------------------------
   AVIS.HEADER
   ROLE: CONSTELLATION_SCANNER_HEADER
   PURPOSE: Header for version scanner.
   AUTHOR: Demon
   ------------------------------------------------------------ */

#ifndef CONSTELLATION_H
#define CONSTELLATION_H

#define MAX_VERSIONS 256
#define MAX_PATH 1024

typedef struct {
    char path[MAX_PATH];
    char name[MAX_PATH];
} VersionEntry;

int is_version_folder(const char *name);
int scan_constellation_folder(const char *repoPath,
                              VersionEntry versions[],
                              int *count);
void print_versions(VersionEntry versions[], int count);

#endif
