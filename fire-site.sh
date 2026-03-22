#!/bin/bash
# IDENTITY: VERSION 3.8 // FIRE-SITE // CVBGOD
# ROLE: Dynamic Sitemap Generation with URL Encoding for Version 1 Spaces.

# 1. Get the base GitHub URL from your git config
REPO_URL=$(git config --get remote.origin.url | sed 's/\.git$//' | sed 's/git@github.com:/https:\/\/github.com\//')
BRANCH="main"
BASE_URL="${REPO_URL}/blob/${BRANCH}"

OUTPUT_FILE="sitemap.xml"

echo "Generating sitemap for: ${BASE_URL}"

# 2. Start the XML structure
echo '<?xml version="1.0" encoding="UTF-8"?>' > $OUTPUT_FILE
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' >> $OUTPUT_FILE

# 3. Find all files (including dots)
# -type f: only files | -not -path '*/.git/*': skip git database
find . -type f -not -path '*/.git/*' | while read -r file; do
    # Remove the leading './'
    CLEAN_PATH="${file#./}"
    
    # URL encode spaces (important for 'Version 1' folders)
    ENCODED_PATH=$(echo "$CLEAN_PATH" | sed 's/ /%20/g')
    
    # Write the URL entry
    echo "  <url>" >> $OUTPUT_FILE
    echo "    <loc>${BASE_URL}/${ENCODED_PATH}</loc>" >> $OUTPUT_FILE
    echo "  </url>" >> $OUTPUT_FILE
done

# 4. Close the tag
echo '</urlset>' >> $OUTPUT_FILE

echo "Done! Full sitemap saved to $OUTPUT_FILE"
