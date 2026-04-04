#!/bin/bash
# =============================================================================
#  AVIS-CORE // SITEMAP GENERATOR [VERSION 1]
#  FILE: fire-map.sh
#  PURPOSE: Index all ASM, INI, and HTML artifacts for the Master Surface
#  GOVERNANCE: CVBGOD // STATUS: VERIFIED
# =============================================================================

SITEMAP="sitemap.xml"
BASE_URL="https://mercwar.github.io"

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $SITEMAP
echo "<urlset xmlns=\"http://www.sitemaps.org\">" >> $SITEMAP

# INDEX THE VAULT (VERSION 1)
for f in "VERSION 1"/*.*; do
    if [ -f "$f" ]; then
        echo "  <url><loc>${BASE_URL}${f// /%20}</loc></url>" >> $SITEMAP
    fi
done

# INDEX THE SURFACE (htdocs)
for f in "htdocs"/*.*; do
    if [ -f "$f" ]; then
        echo "  <url><loc>${BASE_URL}${f// /%20}</loc></url>" >> $SITEMAP
    fi
done

echo "</urlset>" >> $SITEMAP

echo "[AVIS-SH] Sitemap Strike Complete: $SITEMAP created. HAHA!"
