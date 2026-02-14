#!/bin/bash
# =============================================================================
#  AVIS-BOT: fire-map.sh [REVISED]
#  PURPOSE: Map VERSION 1 Protocol files into sitemap.xml
# =============================================================================

# Get the base GitHub URL
REPO_URL=$(git config --get remote.origin.url | sed 's/\.git$//' | sed 's/git@github.com:/https:\/\/github.com\//')
BRANCH="main"
BASE_URL="${REPO_URL}/blob/${BRANCH}"

OUTPUT_FILE="sitemap.xml"

echo "[AVIS-BOT] Striking Sitemap: Mapping fire-protocol.avis..."

# 1. Initialize XML (Direct Strike)
cat <<EOF > $OUTPUT_FILE
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org">
EOF

# 2. Map the Protocol Artifacts
find . -type f \( -name "*.avis" -o -name "*.exe" \) -not -path "*/.git/*" | while read -r file; do
    CLEAN_PATH="${file#./}"
    ENCODED_PATH=$(echo "$CLEAN_PATH" | sed 's/ /%20/g')
    
    echo "  <url>" >> $OUTPUT_FILE
    echo "    <loc>${BASE_URL}/${ENCODED_PATH}</loc>" >> $OUTPUT_FILE
    echo "  </url>" >> $OUTPUT_FILE
done

# 3. Close Tag
echo '</urlset>' >> $OUTPUT_FILE

echo "Done! Full sitemap saved to $OUTPUT_FILE. HAHA!"
