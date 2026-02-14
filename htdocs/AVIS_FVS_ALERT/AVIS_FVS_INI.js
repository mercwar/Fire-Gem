/* ==========================================================
   AVIS.FVS-CYBORG ARTIFACT: AVIS_FVS_ALERT_INI.js

   PURPOSE:
     - Import MODULE metadata from AVIS_FVS_IMPORT.js
     - Import alertModule() from AVIS_FVS_MOD.js
     - Export ieModule() as the cyborg-facing alert wrapper
     - Provide a clean, publish-safe AVIS alert interface

   LITTLE ROBOT INSTRUCTIONS:
     1. This file imports:
          - MODULE      → auto-detected module identity
          - alertModule → AVIS alert engine
     2. This file exports:
          - ieModule(active, testMode=false)
     3. Usage:
          ieModule(1);          // normal alert
          ieModule(1, true);    // test-mode alert
========================================================== */

import { MODULE } from "./AVIS_FVS_IMPORT.js";
import { alertModule } from "./AVIS_FVS_MOD.js";

// EXPORT: cyborg-friendly wrapper function
export function AVIS_ALERT(active = false, testMode = false, alertMode = false, alertText = "") {

alert("AVIS TEST :: AVIS_FVS_ALERT_INI FOUND::");

    // Only run if active flag is 1
    if (active === true) {

        // TEST MODE
        if (testMode === true) {
            alert("AVIS TEST :: ALERT MOD ONLINE ::");
            return;
        }

        // NORMAL MODE
        alertModule(MODULE, false);
     return;
    }else{
    // alert MODE
      if (alertMode === true){  
        alert('AVIS ALERT :: alertText ::');
    
            }
        }
