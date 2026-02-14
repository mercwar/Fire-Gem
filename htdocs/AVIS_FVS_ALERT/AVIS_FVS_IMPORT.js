/* ==========================================================
   AVIS.FVS-CYBORG ARTIFACT: AVIS_FVS_ALERT_IMPORT.js

   PURPOSE:
     - Import MODULE metadata from AVIS_FVS_EXPORT.js.
     - Re-export MODULE for all AVIS/FVS alert components.
     - Provide a stable, publish-safe import point for
       module identity across the AVIS alert subsystem.

   LITTLE ROBOT INSTRUCTIONS:
     1. This file imports:
          - MODULE → auto-detected module identity
     2. It re-exports MODULE for other AVIS units.
     3. Use this file when you need module metadata without
        touching the exporter directly.

   ES MODULE IMPORT USAGE:
     import { MODULE } from "./AVIS_FVS_ALERT_IMPORT.js";
========================================================== */

/* ==========================================================
   AVIS.FVS-CYBORG ARTIFACT: AVIS_FVS_ALERT_IMPORT.js
========================================================== */

import { MODULE } from "./AVIS_FVS_EXPORT.js";

export { MODULE };

alert("AVIS TEST :: ALERT IMPORT ONLINE ::");