/* ==========================================================
   AVIS.FVS-CYBORG ARTIFACT: AVIS_FVS_ALERT_EXPORT.js

   PURPOSE:
     - Auto-detect this module's name with no hard-coded values.
     - Export the MODULE object for all AVIS/FVS alert units.
     - Provide clean, stable metadata for cyborg sub-systems.

   LITTLE ROBOT INSTRUCTIONS:
     1. Read this file's URL via import.meta.url.
     2. Extract the filename.
     3. Strip ".js" and anything after it.
     4. Export MODULE so other AVIS units can use it.

   FILENAME SUPPORT:
     AVIS_FVS_ALERT_EXPORT.js
     AVIS_FVS_ALERT_EXPORT.v1.0.js
     AVIS_FVS_ALERT_EXPORT.min.js
     AVIS_FVS_ALERT_EXPORT.js?cache=123
========================================================== */

const url = import.meta.url;
const file = url.split("/").pop();

// SAFE MODULE NAME EXTRACTION (works for all filename formats)
const moduleName = file.replace(/\.js.*$/, "");

// VERSION EXTRACTION (optional, disabled by design)
// const version = file.match(/\.v([\d\.]+)\.js$/)?.[1] || "0.0";

export const MODULE = {
    moduleName
    // version
};
