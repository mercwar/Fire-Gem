/* FILE: constellation_publisher.c */
/* PATH: /Constellation/constellation_publisher.c */

/* ------------------------------------------------------------
   AVIS.HEADER
   ROLE: CONSTELLATION_PUBLISHER
   PURPOSE: Publishes a validated intelligence.model into the
            AVIS-Datalake, assigning layer, version, and repo
            identity so robots can consume it.
   AUTHOR: Demon
   NOTES: This is the SIXTH CONSTELLATION PROGRAM.
   ------------------------------------------------------------ */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_PATH 1024

/* ------------------------------------------------------------
   FUNCTION: file_exists
   PURPOSE: Simple existence check
   ------------------------------------------------------------ */
int file_exists(const char *path) {
    FILE *f = fopen(path, "rb");
    if (!f) return 0;
    fclose(f);
    return 1;
}

/* ------------------------------------------------------------
   FUNCTION: publish_to_datalake
   PURPOSE: Copies intelligence.model into AVIS-Datalake with
            repo + version tagging.
   ------------------------------------------------------------ */
int publish_to_datalake(const char *repoPath,
                        const char *repoName,
                        const char *versionTag) {

    char modelPath[MAX_PATH];
    snprintf(modelPath, sizeof(modelPath),
             "%s/Constellation/intelligence.model", repoPath);

    if (!file_exists(modelPath)) {
        printf("ERROR: intelligence.model not found: %s\n", modelPath);
        return 0;
    }

    char targetPath[MAX_PATH];
    snprintf(targetPath, sizeof(targetPath),
             "/AVIS-DATALAKE/%s/%s.model", repoName, versionTag);

    printf("Publishing model:\n");
    printf(" - Source: %s\n", modelPath);
    printf(" - Target: %s\n", targetPath);

    FILE *in = fopen(modelPath, "rb");
    if (!in) {
        printf("ERROR: Failed to open source model.\n");
        return 0;
    }

    FILE *out = fopen(targetPath, "wb");
    if (!out) {
        printf("ERROR: Failed to open target path.\n");
        fclose(in);
        return 0;
    }

    char buffer[4096];
    size_t bytes;

    while ((bytes = fread(buffer, 1, sizeof(buffer), in)) > 0) {
        fwrite(buffer, 1, bytes, out);
    }

    fclose(in);
    fclose(out);

    printf("Publish complete — AVIS-Datalake updated.\n");
    return 1;
}

/* ------------------------------------------------------------
   MAIN PROGRAM
   PURPOSE: Entry point for the Constellation Publisher
   USAGE:
     constellation_publisher <repo-path> <repo-name> <version-tag>
   ------------------------------------------------------------ */
int main(int argc, char *argv[]) {

    if (argc < 4) {
        printf("Usage: constellation_publisher <repo-path> <repo-name> <version-tag>\n");
        return 1;
    }

    const char *repoPath   = argv[1];
    const char *repoName   = argv[2];
    const char *versionTag = argv[3];

    printf("Starting publish for repo: %s (version: %s)\n",
           repoName, versionTag);

    if (!publish_to_datalake(repoPath, repoName, versionTag)) {
        printf("Constellation publish FAILED.\n");
        return 1;
    }

    printf("Constellation publish SUCCESS.\n");
    return 0;
}
