#!/bin/bash
# VERSION 1/fire-map.sh
REPO_URL=$(git config --get remote.origin.url | sed 's/\.git$//' | sed 's/git@github.com:/https:\/\/github.com\//')
BASE_URL="${REPO_URL}/blob/main"

echo '<?xml version="1.0" encoding="UTF-8"?>' > sitemap.xml
echo '<urlset xmlns="http://www.sitemaps.org">' >> sitemap.xml

find "VERSION 1/fire-log" -name "*.avis" | while read -r file; do
    ENCODED=$(echo "$file" | sed 's/ /%20/g')
    echo "  <url><loc>${BASE_URL}/${ENCODED}</loc><priority>1.0</priority></url>" >> sitemap.xml
done

echo "</urlset>" >> sitemap.xml
