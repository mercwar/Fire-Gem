     function toggleStart() {
            const m = document.getElementById('start-menu');
            m.style.display = (m.style.display === 'flex') ? 'none' : 'flex';
        }

        function createWindow(id, url) {
            if(document.getElementById(id)) return;
            const win = document.createElement('div');
            win.id = id;
            win.className = 'fgeo-window';
            win.style.top = '50px'; win.style.left = '100px';
            win.style.width = '80%'; win.style.height = '70%';

            win.innerHTML = `
                <div class="title-bar" onmousedown="dragStart(event, '${id}')">
                    <span>${id}</span>
                    <div class="controls">
                        <span onclick="minWin('${id}')">_</span>
                        <span onclick="maxWin('${id}')">[]</span>
                        <span onclick="closeWin('${id}')">X</span>
                    </div>
                </div>
                <div class="window-body">
                    <iframe src="${url}"></iframe>
                </div>
            `;
            document.getElementById('desktop').appendChild(win);
            toggleStart();
        }

        // WINDOW CONTROLS
        function closeWin(id) { document.getElementById(id).remove(); }
        function minWin(id) { document.getElementById(id).classList.toggle('minimized'); }
        function maxWin(id) {
            const w = document.getElementById(id);
            if(w.style.width === '100%') { w.style.width = '80%'; w.style.height = '70%'; }
            else { w.style.width = '100%'; w.style.height = 'calc(100vh - 25px)'; w.style.top='0'; w.style.left='0'; }
        }

        // DRAG LOGIC
        let activeWin = null;
        function dragStart(e, id) {
            activeWin = document.getElementById(id);
            let offset = [activeWin.offsetLeft - e.clientX, activeWin.offsetTop - e.clientY];
            document.onmousemove = (ev) => {
                activeWin.style.left = (ev.clientX + offset[0]) + 'px';
                activeWin.style.top = (ev.clientY + offset[1]) + 'px';
            };
            document.onmouseup = () => { document.onmousemove = null; };
        }
