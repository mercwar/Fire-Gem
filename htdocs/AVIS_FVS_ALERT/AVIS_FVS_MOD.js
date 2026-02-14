/* ==========================================================
   AVIS.FVS-CYBORG ARTIFACT: AVIS_FVS_ALERT_MOD.js

   PURPOSE:
     - Provide a centralized alert function for the AVIS/FVS
       subsystem.
     - Optionally display MODULE metadata in the alert.
     - Maintain simple, AVIS-branded UI feedback.

   LITTLE ROBOT INSTRUCTIONS:
     1. Import alertModule() wherever you need a system alert.
     2. Optionally pass MODULE for contextual identity info.
     3. This file does NOT execute by itself; it only exports.

   ES MODULE IMPORT USAGE:
     import { alertModule } from "./AVIS_FVS_ALERT_MOD.js";
     alertModule(MODULE);
========================================================== */

/* ==========================================================
   AVIS.FVS-CYBORG ARTIFACT: AVIS_FVS_ALERT_MOD.js
========================================================== */

export function alertModule(moduleData, testMode = false) {

    // TEST MODE
    if (testMode === true) {
        alert("AVIS :: ieModule( -TEST MODULE ONLINE- ) ::");
        return;
    }

    // NORMAL MODE WITH MODULE NAME
    if (moduleData && moduleData.moduleName) {
        alert(`AVIS :: MODULE ONLINE :DATA: ${moduleData.moduleName}`);
        return;
    }

    // FALLBACK MODE
    alert("AVIS :: MODULE OFFLINE ::");
}
