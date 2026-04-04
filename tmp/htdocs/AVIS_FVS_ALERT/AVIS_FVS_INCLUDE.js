/* ==========================================================
   AVIS.FVS-CYBORG ARTIFACT: AVIS_FVS_INCLUDE.js

   PURPOSE:
     - Provide a simple JavaScript include function.
     - Allow AI/cyborg units to load ES modules dynamically.
     - Maintain minimal, readable logic for small robots.

   LITTLE ROBOT INSTRUCTIONS:
     1. Call includeJS("file.js") to load another module.
     2. The function creates a <script type="module"> tag.
     3. The browser loads and executes the ES module.
     4. No hard-coded filenames are required.

   JS INCLUDE FUNCTION (DYNAMIC ES MODULE):
     import { includeJS } from "./AVIS_FVS_INCLUDE.js";
     includeJS("AVIS_FVS_ALERT_INI.js");
========================================================== */

/* ==========================================================
   AVIS.FVS-CYBORG ARTIFACT: AVIS_FVS_INCLUDE.js
========================================================== */

export function includeJS(url) {
    const script = document.createElement("script");
    script.type = "module";
    script.src = url;
    document.head.appendChild(script);
}

