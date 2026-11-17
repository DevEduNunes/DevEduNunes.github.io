#!/usr/bin/env bash
# Cache busting: acrescenta ?v=<hash do arquivo> nos CSS/JS referenciados pelos HTMLs.
# O GitHub Pages e a Cloudflare guardam CSS/JS em cache, entao sem isso visitantes
# continuam com a versao antiga depois de um deploy. A URL nova (com o hash)
# forca a busca; e o hash so muda quando o arquivo muda.
set -euo pipefail

for f in $(grep -hoE 'assets/(css|js)/[A-Za-z0-9._-]+\.(css|js)' *.html | sort -u); do
  [ -f "$f" ] || continue
  h=$(sha1sum "$f" | cut -c1-8)
  sed -i "s#\"$f\"#\"$f?v=$h\"#g" *.html
done
