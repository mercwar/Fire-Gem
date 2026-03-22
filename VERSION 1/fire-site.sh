#!/bin/bash
# =============================================================================
#  AVIS-BOT: DYNAMIC REPO MAPPER [VERSION 1]
#  FILE: fire-site.sh
#  PURPOSE: Map VERSION 1 artifacts using git remote origin authority.
# =============================================================================

# 1. Get the base GitHub URL from your git config
# This ensures the sitemap is repo-agnostic
REPO_URL=$(git config --get remote.origin.url | sed 's/\.git$//' | sed 's/git@github.com:/https:\/\/github.com\//')
BRANCH="main"
BASE_URL="${REPO_URL}/blob/${BRANCH}"

OUTPUT_FILE="sitemap.xml"
LOG="VERSION 1/fire-gem.log"

echo "[AVIS-BOT] Generating sitemap for: ${BASE_URL}" >> "$LOG"

# 2. Start the XML structure
echo '<?xml version="1.0" encoding="UTF-8"?>' > $OUTPUT_FILE
echo '<urlset xmlns="http://www.sitemaps.org">' >> $OUTPUT_FILE

# 3. Find all files (including dots)
# Space-encoding handles the "VERSION 1" directory name perfectly
find . -type f -not -path '*/.git/*' | while read -r file; do
    # Remove the leading './'
    CLEAN_PATH="${file#./}"
    
    # URL encode spaces for 'VERSION 1' and .so artifacts
    ENCODED_PATH=$(echo "$CLEAN_PATH" | sed 's/ /%20/g')
    
    echo "  <url>" >> $OUTPUT_FILE
    echo "    <loc>${BASE_URL}/${ENCODED_PATH}</loc>" >> $OUTPUT_FILE
    echo "  </url>" >> $OUTPUT_FILE
done

# 4. Close the tag
echo '</urlset>' >> $OUTPUT_FILE

echo "[AVIS-BOT] Sitemap Strike Complete: $OUTPUT_FILE saved. HAHA!" >> "$LOG"
