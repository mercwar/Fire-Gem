/* FILE: constellation_publisher.h */
/* PATH: /Constellation/constellation_publisher.h */

/* ------------------------------------------------------------
   AVIS.HEADER
   ROLE: CONSTELLATION_PUBLISHER_HEADER
   PURPOSE: Header for the Constellation Publisher.
   AUTHOR: Demon
   NOTES: Sixth header in the Constellation chain.
   ------------------------------------------------------------ */

#ifndef CONSTELLATION_PUBLISHER_H
#define CONSTELLATION_PUBLISHER_H

#define MAX_PATH 1024

int file_exists(const char *path);
int publish_to_datalake(const char *repoPath,
                        const char *repoName,
                        const char *versionTag);

#endif
