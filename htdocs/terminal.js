/* =============================================================
   AVIS TERMINAL ENGINE [VERSION 1]
   FILE: htdocs/terminal.js
   PURPOSE: Parse <avis-obj> and Stream fire-gem.log
   ============================================================= */

async function strikeTerminal() {
    const response = await fetch('../VERSION 1/fire-gem.log');
    const text = await response.text();
    const terminalSurface = document.getElementById('avis-terminal');

    // Clear and Redraw the Surface
    terminalSurface.innerHTML = '';
    
    // Parse the AVIS Encapsulation
    const lines = text.split('\n');
    lines.forEach(line => {
        if (line.includes('<avis-obj')) {
            const entry = document.createElement('div');
            entry.className = 'avis-strike';
            // Extract the Level 2 Content
            entry.innerHTML = line.replace(/<avis-obj.*?>|<\/avis-obj>/g, '');
            terminalSurface.appendChild(entry);
        } else if (line.trim() !== '') {
            const raw = document.createElement('div');
            raw.className = 'raw-trace';
            raw.innerText = line;
            terminalSurface.appendChild(raw);
        }
    });
}

// Set the Heartbeat for the Net Intake
setInterval(strikeTerminal, 2000);
