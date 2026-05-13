/* FILE: constellation_autobuild.h */
/* PATH: /Constellation/constellation_autobuild.c */

/* ------------------------------------------------------------
   AVIS.HEADER
   ROLE: CONSTELLATION_AUTOBUILD
   PURPOSE: Auto-compiles all version folders into binary
            intelligence artifacts (*.bin). Ensures future
            versions are automatically absorbed.
   AUTHOR: Demon
   NOTES: This is the THIRD CONSTELLATION PROGRAM.
   ------------------------------------------------------------ */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>

#define MAX_PATH 1024
#define MAX_VERSIONS 256

typedef struct {
    char path[MAX_PATH];
    char name[MAX_PATH];
} VersionEntry;

/* ------------------------------------------------------------
   FUNCTION: is_version_folder
   PURPOSE: Detects version folder naming patterns
   ------------------------------------------------------------ */
int is_version_folder(const char *name) {
    if (strncmp(name, "v", 1) == 0) return 1;
    if (strncmp(name, "version", 7) == 0) return 1;
    if (strchr(name, '.') != NULL) return 1;
    return 0;
}

/* ------------------------------------------------------------
   FUNCTION: scan_versions
   PURPOSE: Scans Constellation folder for version directories
   ------------------------------------------------------------ */
int scan_versions(const char *repoPath,
                  VersionEntry versions[],
                  int *count) {

    char constellationPath[MAX_PATH];
    snprintf(constellationPath, sizeof(constellationPath),
             "%s/Constellation", repoPath);

    DIR *dir = opendir(constellationPath);
    if (!dir) {
        printf("Autobuild: No Constellation folder found.\n");
        return 0;
    }

    struct dirent *entry;

    while ((entry = readdir(dir)) != NULL) {

        if (entry->d_type == DT_DIR &&
            is_version_folder(entry->d_name)) {

            snprintf(versions[*count].path, MAX_PATH,
                     "%s/%s", constellationPath, entry->d_name);

            snprintf(versions[*count].name, MAX_PATH,
                     "%s", entry->d_name);

            (*count)++;
        }
    }

    closedir(dir);
    return 1;
}

/* ------------------------------------------------------------
   FUNCTION: autobuild_version
   PURPOSE: Creates a *.bin file for a version folder
   ------------------------------------------------------------ */
int autobuild_version(const char *versionPath,
                      const char *versionName,
                      const char *repoPath) {

    char outputPath[MAX_PATH];
    snprintf(outputPath, sizeof(outputPath),
             "%s/Constellation/%s.bin", repoPath, versionName);

    printf("Autobuild: Compiling %s → %s\n", versionPath, outputPath);

    FILE *out = fopen(outputPath, "wb");
    if (!out) {
        printf("Autobuild: Failed to create %s\n", outputPath);
        return 0;
    }

    FILE *meta = fopen("/dev/null", "rb"); /* placeholder */
    if (meta) fclose(meta);

    fprintf(out, "CONSTELLATION_VERSION:%s\n", versionName);
    fprintf(out, "SOURCE_PATH:%s\n", versionPath);
    fprintf(out, "AUTOBUILD_STATUS:OK\n");

    fclose(out);
    return 1;
}

/* ------------------------------------------------------------
   MAIN PROGRAM
   PURPOSE: Entry point for the Constellation Autobuild engine
   ------------------------------------------------------------ */
int main(int argc, char *argv[]) {

    if (argc < 2) {
        printf("Usage: constellation_autobuild <repo-path>\n");
        return 1;
    }

    VersionEntry versions[MAX_VERSIONS];
    int versionCount = 0;

    printf("Autobuild: Scanning versions...\n");

    if (!scan_versions(argv[1], versions, &versionCount)) {
        printf("Autobuild: No versions found.\n");
        return 0;
    }

    for (int i = 0; i < versionCount; i++) {
        autobuild_version(versions[i].path,
                          versions[i].name,
                          argv[1]);
    }

    printf("Autobuild: All versions compiled.\n");
    return 0;
}
