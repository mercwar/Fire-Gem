/* =============================================================
   AVIS-CORE // WINDOW MANAGER
   FILE: htdocs/fire-term-1.js
   PURPOSE: Draggable FGEO Windows with AVIS Reporting
   ============================================================= */

AVIS_STRIKE("SEATING_WINDOW_MANAGER", 1);

window.createWindow = function(id, url) {
    AVIS_STRIKE(`STRIKE: OPEN_WINDOW [${id}] -> ${url}`, 2);
    const desktop = document.getElementById('desktop');
    if (!desktop) { AVIS_STRIKE("ERR: DESKTOP_LAYER_MISSING", 1); return; }

    const win = document.createElement('div');
    win.id = id;
    win.className = 'fgeo-window';
    
    win.innerHTML = `
        <div class="title-bar" onmousedown="dragStart(event, '${id}')">
            <span>[OBJ]: ${id}</span>
            <div class="controls">
                <span onclick="maxWin('${id}')">[]</span>
                <span onclick="document.getElementById('${id}').remove(); AVIS_STRIKE('CLOSE_WINDOW: ${id}', 1)">X</span>
            </div>
        </div>
        <div class="window-body"><iframe src="${url}"></iframe></div>
    `;
    desktop.appendChild(win);
};

window.maxWin = function(id) {
    const w = document.getElementById(id);
    AVIS_STRIKE(`SWITCH: MAXIMIZE_TOGGLE [${id}]`, 1);
    if (w.style.width === '100vw') {
        w.style.width = '800px'; w.style.height = '500px';
    } else {
        w.style.width = '100vw'; w.style.height = 'calc(100vh - 25px)';
        w.style.top = '0'; w.style.left = '0';
    }
};

AVIS_STRIKE("WINDOW_MANAGER_ACTIVE. HAHA!", 2);
