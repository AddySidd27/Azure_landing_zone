#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
check_external=false

if [[ "${1:-}" == "--external" ]]; then
  check_external=true
fi

failed=0

while IFS= read -r record; do
  file="${record%%:*}"
  remainder="${record#*:}"
  line="${remainder%%:*}"
  target="${remainder#*:}"

  case "$target" in
    http://*|https://*|mailto:*|\#*|"") continue ;;
  esac

  target="${target%%#*}"
  target="${target%%\?*}"

  if [[ ! -e "$repo_root/$(dirname "$file")/$target" ]]; then
    echo "FAIL: $file:$line -> $target"
    failed=1
  fi
done < <(
  cd "$repo_root"
  rg -n -o '\[[^]]+\]\(([^)]+)\)' --glob '*.md' |
    sed -E 's#^([^:]+):([0-9]+):.*\]\(([^)]+)\)$#\1:\2:\3#'
)

if [[ "$check_external" == true ]]; then
  while IFS= read -r url; do
    if curl --fail --location --silent --show-error --max-time 30 --retry 2 \
      --user-agent 'Azure-Landing-Zone-link-check' \
      --output /dev/null "$url"; then
      echo "PASS: $url"
    else
      echo "FAIL: $url"
      failed=1
    fi
  done < <(
    cd "$repo_root"
    rg -o 'https://[^)> ]+' --glob '*.md' | cut -d: -f2- | sort -u
  )
fi

if [[ "$failed" -eq 0 ]]; then
  echo "PASS: documentation links"
fi

exit "$failed"
