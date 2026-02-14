#!/bin/bash
# VERSION 1/fire-map.sh
# MISSION: Inform crawlers of the new HTML-Wrapped AVIS Objects

BASE_URL="https://mercwar.github.io"

# Force the XML Printout
cat <<EOF > sitemap.xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org">
EOF

# Find every .avis event object
find "VERSION 1/fire-log" -name "*.avis" | while read -r file; do
    echo "  <url><loc>${BASE_URL}/$(basename "$file")</loc><priority>1.0</priority></url>" >> sitemap.xml
done

echo "</urlset>" >> sitemap.xml
