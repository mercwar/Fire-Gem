/* FILE: constellation_reduce.h */
/* PATH: /Constellation/constellation_reduce.h */

/* ------------------------------------------------------------
   AVIS.HEADER
   ROLE: CONSTELLATION_REDUCER_HEADER
   PURPOSE: Header for the Constellation Reducer.
   AUTHOR: Demon
   NOTES: This is the SECOND HEADER in the Constellation chain.
   ------------------------------------------------------------ */

#ifndef CONSTELLATION_REDUCE_H
#define CONSTELLATION_REDUCE_H

#define MAX_PATH 1024

int is_garbage(const char *name);
int reduce_folder(const char *path);

#endif
