/* FILE: constellation.c */
/* PATH: /Constellation/constellation.c */

/* ------------------------------------------------------------
   AVIS.HEADER
   ROLE: CONSTELLATION_SCANNER
   PURPOSE: Scans repos for Constellation folders and loads all
            versioned intelligence (past, present, future).
   AUTHOR: Demon
   ------------------------------------------------------------ */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>

#define MAX_VERSIONS 256
#define MAX_PATH 1024

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
   FUNCTION: scan_constellation_folder
   PURPOSE: Scans the Constellation folder for version folders
            and version files (*.version)
   ------------------------------------------------------------ */
int scan_constellation_folder(const char *repoPath,
                              VersionEntry versions[],
                              int *count) {
    char fullPath[MAX_PATH];
    snprintf(fullPath, sizeof(fullPath), "%s/Constellation", repoPath);

    DIR *dir = opendir(fullPath);
    if (!dir) {
        printf("No Constellation folder found in: %s\n", repoPath);
        return 0;
    }

    struct dirent *entry;
    while ((entry = readdir(dir)) != NULL) {

        if (entry->d_type == DT_DIR) {
            if (is_version_folder(entry->d_name)) {
                snprintf(versions[*count].path, MAX_PATH,
                         "%s/%s", fullPath, entry->d_name);
                snprintf(versions[*count].name, MAX_PATH,
                         "%s", entry->d_name);
                (*count)++;
            }
        }

        if (entry->d_type == DT_REG) {
            if (strstr(entry->d_name, ".version") != NULL) {
                snprintf(versions[*count].path, MAX_PATH,
                         "%s/%s", fullPath, entry->d_name);
                snprintf(versions[*count].name, MAX_PATH,
                         "%s", entry->d_name);
                (*count)++;
            }
        }
    }

    closedir(dir);
    return 1;
}

/* ------------------------------------------------------------
   FUNCTION: print_versions
   PURPOSE: Prints the discovered version tree
   ------------------------------------------------------------ */
void print_versions(VersionEntry versions[], int count) {
    printf("\n=== CONSTELLATION VERSION TREE ===\n");
    for (int i = 0; i < count; i++) {
        printf(" - %s  (%s)\n", versions[i].name, versions[i].path);
    }
    printf("=================================\n\n");
}

/* ------------------------------------------------------------
   MAIN PROGRAM
   PURPOSE: Entry point for the Constellation Scanner
   ------------------------------------------------------------ */
int main(int argc, char *argv[]) {

    if (argc < 2) {
        printf("Usage: constellation <repo-path>\n");
        return 1;
    }

    VersionEntry versions[MAX_VERSIONS];
    int versionCount = 0;

    printf("Scanning repo: %s\n", argv[1]);

    if (!scan_constellation_folder(argv[1], versions, &versionCount)) {
        printf("No versions found.\n");
        return 0;
    }

    print_versions(versions, versionCount);

    printf("Constellation intelligence loaded.\n");
    return 0;
}
