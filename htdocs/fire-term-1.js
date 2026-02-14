/* FIX: Precise calculation for Taskbar height and Window parent access */
function createWindow(id, url) {
    if(document.getElementById(id)) return;
    const desktop = document.getElementById('desktop');
    const win = document.createElement('div');
    win.id = id;
    win.className = 'fgeo-window';
    win.style.width = '800px'; 
    win.style.height = '500px';
    win.style.top = '50px'; 
    win.style.left = '50px';

    win.innerHTML = `
        <div class="title-bar" onmousedown="dragStart(event, '${id}')">
            <span>[OBJ]: ${id}</span>
            <div class="controls">
                <span onclick="minWin('${id}')">_</span>
                <span onclick="maxWin('${id}')">[]</span>
                <span onclick="closeWin('${id}')">X</span>
            </div>
        </div>
        <div class="window-body"><iframe src="${url}"></iframe></div>
    `;
    desktop.appendChild(win);
}

function maxWin(id) {
    const w = document.getElementById(id);
    if(w.style.width === '100vw') {
        w.style.width = '800px'; w.style.height = '500px';
        w.style.top = '50px'; w.style.left = '50px';
    } else {
        w.style.width = '100vw'; 
        w.style.height = 'calc(100vh - 25px)'; // CLIPPING FIX
        w.style.top = '0'; w.style.left = '0';
    }
}
