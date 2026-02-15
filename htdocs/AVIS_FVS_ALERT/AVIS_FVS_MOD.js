/* ==========================================================
   AVIS.FVS-CYBORG ARTIFACT: AVIS_FVS_MOD.js
   AIFVS-ARTIFACT
========================================================== */

import { AVIS_TERM } from "./AVIS_FVS_IMPORT.js";


export function avisAlert(AVIS_MSG_PARAM = "", testMode = false, sendText = false) {

    let ALERT_MSG = "AVIS ALERT :: MOD";

    if (AVIS_MSG_PARAM !== "") {
        ALERT_MSG = AVIS_MSG_PARAM;
    }

    // SAFE: AVIS_TERM is called only if it exists
    if (typeof AVIS_TERM === "function") {
        AVIS_TERM(ALERT_MSG);
    }

    if (sendText === true) return;

    alert(ALERT_MSG);
}


export function alertModule(moduleData, testMode = false, sendText = false) {

    if (testMode === true) {
        avisAlert("AVIS :: TEST MODULE ONLINE ::", testMode, sendText);
        return;
    }

    if (moduleData && moduleData.moduleName) {
        avisAlert(`AVIS :: MODULE ONLINE : ${moduleData.moduleName}`, testMode, sendText);
        return;
    }

    avisAlert("AVIS :: MODULE OFFLINE ::", testMode, sendText);
}

