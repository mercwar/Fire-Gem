/* ==========================================================
   AVIS.FVS-CYBORG ARTIFACT: AVIS_FVS_INI.js
   AIFVS-ARTIFACT
========================================================== */
import { MODULE } from "./AVIS_FVS_EXPORT.js";
import { alertModule, avisAlert } from "./AVIS_FVS_MOD.js";
import { AVIS_MSG } from "./AVIS_FVS_IMPORT.js";
import { AVIS_MSG_ERR } from "./AVIS_FVS_IMPORT.js";

export { MODULE };
export { AVIS_MSG };
export { AVIS_MSG_ERR };

import { AVIS_TERM } from "./AVIS_FVS_IMPORT.js";

export function AVIS_ALERT(active= false,testMode = false, alertMode = false,alertText = "",sendText = false) {

 AVIS_TERM(alertText);

    if (active === true) {

        if (testMode === true) {
            avisAlert("AVIS TEST:: MODE",sendText);
            return;
        }

        alertModule(MODULE, false, sendText);
        return;
    }

    if (alertMode === true) {
        avisAlert(`AVIS ALERT :: ${alertText}`, sendText);
    }

}
