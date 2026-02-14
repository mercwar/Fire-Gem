/* =============================================================
   AVIS-CORE // MASTER TERMINAL LOGIC
   FILE: htdocs/fire-term.js
   PURPOSE: Log Audit & AVIS Debug Wrapper
   ============================================================= */

// THE AVIS VOICE (JS VERSION)
function AVIS_LOG(msg, lvl = 2) {
    const auditSurface = document.getElementById('llm-audit-surface');
    if (!auditSurface) return;
    
    const timestamp = new Date().toISOString().split('T')[1].split('.')[0];
    const entry = document.createElement('div');
    entry.style.color = lvl === 1 ? '#C0C0C0' : '#FFD700'; // Silver or Gold
    entry.innerHTML = `<span style="color:#666">[${timestamp}]</span> <avis-obj data-lvl='${lvl}'>[AVIS-JS] ${msg}</avis-obj>`;
    
    const list = document.getElementById('strike-list');
    if (list) {
        list.prepend(entry);
    }
    console.log(`[AVIS-STRIKE] ${msg}`);
}

// WRAP THE IGNITION
try {
    AVIS_LOG("Igniting Terminal Engine...", 1);
    // ... sitemap and log fetch logic ...
    AVIS_LOG("Terminal Engine Online. HAHA!", 2);
} catch (e) {
    AVIS_LOG(`CRITICAL_CRASH: ${e.message}`, 1);
}
