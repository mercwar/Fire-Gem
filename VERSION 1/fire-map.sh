#!/bin/bash
# VERSION 1/fire-map.sh [CVBGOD EDITION]

REPO_URL=$(git config --get remote.origin.url | sed 's/\.git$//' | sed 's/git@github.com:/https:\/\/github.com\//')
BASE_URL="${REPO_URL}/blob/main"

echo "[AVIS-MAP] CVBGOD AUTHORITY: Mapping Vault Artifacts..."

cat <<EOF > sitemap.xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org">
EOF

# Map the Sealed Vault Artifacts with 1.0 Priority
find "VERSION 1/fire-log" -name "*.avis" | while read -r file; do
    ENCODED=$(echo "$file" | sed 's/ /%20/g')
    echo "  <url>" >> sitemap.xml
    echo "    <loc>${BASE_URL}/${ENCODED}</loc>" >> sitemap.xml
    echo "    <priority>1.0</priority>" >> sitemap.xml
    echo "  </url>" >> sitemap.xml
done

echo "</urlset>" >> sitemap.xml
echo "[AVIS-MAP] Sitemap.xml Sealed by CVBGOD. HAHA!"
