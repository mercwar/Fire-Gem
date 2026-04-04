#!/bin/bash
# IDENTITY: VERSION 3.7 // FIRE-END // JOE TRON
# ROLE: Final Seal and Git Dispatch - NO SITEMAP FALLBACK

# 1. CALL SITE GENERATOR
if [ -f "./fire-site.sh" ]; then
    chmod +x fire-site.sh
    ./fire-site.sh
    echo "wm_macro_ack: fire-site triggered."
else
    echo "AVIS_ERROR: fire-site.sh not found."
fi

# 2. CONFIGURE BOT IDENTITY
git config --global user.name "github-actions[bot]"
git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"

# 3. STAGE ARTIFACTS
# Adding specific targets to avoid "Is a directory" errors
git add *.log 2>/dev/null
git add *.exe 2>/dev/null
git add *_bin 2>/dev/null
git add sitemap.xml 2>/dev/null
git add .

# 4. DISPATCH TO ORIGIN
if ! git diff --staged --quiet; then
    git commit -m "AVIS: Joe Tron Pulse - Identity Verified [HAHA!]"
    git pull --rebase -X ours origin main
    git push origin main
    echo "wm_macro_ack: GIT DISPATCH SUCCESSFUL."
else
    echo "AVIS: No changes detected. Dispatch idle."
fi
