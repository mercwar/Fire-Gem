/* -------AVIS.FVS-CYBORG ARTIFACT: alert-------------------- */
import { AVIS_ALERT } from "./AVIS_FVS_ALERT/AVIS_FVS_INI.js";
/* ---------------------------------------------------------- */

/* -------AVIS.FVS-CYBORG ARTIFACT: alert-------------------- */
/* REFERENCE:
   MSG_TXT       → true = text-only mode
   MSG_SYS_ON    → system active
   MSG_SYS_OFF   → system inactive
   MSG_TEST_ON   → test mode enabled
   MSG_TEST_OFF  → test mode disabled
   MSG_ALERT_ON  → show popup alert
   MSG_ALERT_OFF → no popup alert
   MSG_NULL      → empty text payload
   MSG_ID        → identity string
   MSG_AVIS_ALERT→ stores returned alert text
*/
let MSG_TXT = true;
let MSG_SYS_ON = true;
let MSG_SYS_OFF = false;
let MSG_TEST_ON = true;
let MSG_TEST_OFF = false;
let MSG_ALERT_ON  = true;
let MSG_ALERT_OFF  = false;
let MSG_NULL  = "";
let MSG_ID  = "AVIS.FVS-CYBORG ARTIFACT";
let MSG_AVIS_ALERT  = "";

/* REFERENCE:
   AVIS_ALERT(MSG_SYS, MSG_TEST, MSG_ALERT, MSG_TEXT, MSG_TXT)

   Example:
     AVIS_ALERT(true, false, true, "Hello", false)

   Meaning:
     system on,
     test mode off,
     show popup alert,
     message = "Hello",
     not text-only mode
*/
MSG_AVIS_ALERT = AVIS_ALERT(
    MSG_SYS_ON,
    MSG_TEST_ON,
    MSG_ALERT_OFF,
    MSG_NULL,
    MSG_TXT
);
/* ---------------------------------------------------------- */

/* -------AVIS.FVS-CYBORG ARTIFACT: alert-------------------- */
/* REFERENCE:
   // AVIS_ALERT(MSG_SHOW, MSG_TEST, MSG_ALERT, MSG_TEXT);
*/
/* ---------------------------------------------------------- */


/* ==========================================================
   NEW EXPORT (ADDED WITHOUT MODIFYING ANY EXISTING CODE)
   REFERENCE:
     Import this if you need the computed alert value.

     import { MSG_AVIS_ALERT } from "./AVIS_FVS_ALERT_MOD.js";
========================================================== */
export { MSG_AVIS_ALERT };


If you want, I can also generate a **matching reference card** (like a cheat‑sheet block) you can drop into your repo so every module knows how to call AVIS_ALERT without guessing.
