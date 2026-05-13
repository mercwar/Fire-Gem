/* FILE: constellation_autobuild.h */
/* PATH: /Constellation/constellation_autobuild.h */

/* ------------------------------------------------------------
   AVIS.HEADER
   ROLE: CONSTELLATION_AUTOBUILD_HEADER
   PURPOSE: Header for the Constellation Autobuild engine.
   AUTHOR: Demon
   NOTES: This is the THIRD HEADER in the Constellation chain.
   ------------------------------------------------------------ */

#ifndef CONSTELLATION_AUTOBUILD_H
#define CONSTELLATION_AUTOBUILD_H

#define MAX_PATH 1024
#define MAX_VERSIONS 256

typedef struct {
    char path[MAX_PATH];
    char name[MAX_PATH];
} VersionEntry;

int is_version_folder(const char *name);
int scan_versions(const char *repoPath,
                  VersionEntry versions[],
                  int *count);
int autobuild_version(const char *versionPath,
                      const char *versionName,
                      const char *repoPath);

#endif
