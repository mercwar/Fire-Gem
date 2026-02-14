/* ==========================================================
   AVIS.FVS-CYBORG ARTIFACT: AVIS_FVS_ALERT_MOD.js

   PURPOSE:
     - Provide a centralized alert function for the AVIS/FVS subsystem.
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

export let AVIS_MSG = "";

/**
 * Core alert engine.
 * Handles:
 *  - testMode (visual alert)
 *  - sendText (silent text-only mode)
 *  - moduleData (identity metadata)
 */
export function avisAlert(message, testMode = false, sendText = false) {

    // TEXT-ONLY MODE (no alert popup)
    if (sendText === true) {
        AVIS_MSG = message;
        return;
    }

    // VISUAL ALERT MODE
    alert(message);
}


/**
 * Public-facing wrapper.
 * Normalizes moduleData and routes to avisAlert().
 */
export function alertModule(moduleData, testMode = false, sendText = false) {

    // TEST MODE
    if (testMode === true) {
        avisAlert("AVIS :: ieModule( -TEST MODULE ONLINE- ) ::", testMode, sendText);
        return;
    }

    // NORMAL MODE WITH MODULE DATA
    if (moduleData && moduleData.moduleName) {
        avisAlert(`AVIS :: MODULE ONLINE :DATA: ${moduleData.moduleName}`, testMode, sendText);
        return;
    }

    // FALLBACK MODE
    avisAlert("AVIS :: MODULE OFFLINE ::", testMode, sendText);
}

