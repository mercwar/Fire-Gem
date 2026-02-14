/* =============================================================
   AVIS-CORE // MASTER TERMINAL LOGIC
   FILE: htdocs/fire-term.js
   PURPOSE: Log Audit & AVIS Hardware Reporting
   ============================================================= */

function AVIS_STRIKE(msg, lvl = 2) {
    const list = document.getElementById('strike-list');
    const timestamp = new Date().toISOString();
    console.log(`[AVIS-SYSTEM] ${msg}`);
    if (list) {
        const entry = document.createElement('li');
        entry.style.color = (lvl === 1) ? '#C0C0C0' : '#FFD700'; // Silver or Gold
        entry.innerHTML = `<span style="color:#666">[${timestamp}]</span> <avis-obj data-lvl='${lvl}'>[VERIFIED]: ${msg}</avis-obj>`;
        list.prepend(entry);
    }
}

async function auditLog() {
    try {
        const response = await fetch('VERSION 1/fire-gem.log');
        if (!response.ok) throw new Error("VAULT_LOCKED");
        const text = await response.text();
        
        // Parse the AVIS Encapsulated Objects from the Hardware Log
        const lines = text.split('\n');
        lines.forEach(line => {
            if (line.includes('[LLM-LOG-OBJ]')) {
                AVIS_STRIKE(line.replace('[LLM-LOG-OBJ]', ''), 2);
            }
        });
    } catch (e) {
        AVIS_STRIKE(`LOG_POLL_WAIT: ${e.message}`, 1);
    }
}

// TERMINAL IGNITION
try {
    AVIS_STRIKE("TERMINAL_ENGINE_IGNITION", 2);
    setInterval(auditLog, 3000);
} catch (e) {
    AVIS_STRIKE(`CRITICAL_CORE_ERR: ${e.message}`, 1);
}
