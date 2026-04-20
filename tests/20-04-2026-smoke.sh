#!/usr/bin/env bash
set -euo pipefail

FILE="20-04-2026.html"

[[ -f "$FILE" ]] || { echo "Missing $FILE"; exit 1; }

for needle in \
  'id="overview"' \
  'id="focus"' \
  'id="incidents"' \
  'id="warehouse"' \
  'id="website"' \
  'id="decisions"' \
  'Отчет IT-отдела' \
  'Итоги недели и ключевые проекты'; do
  grep -q "$needle" "$FILE" || { echo "Missing: $needle"; exit 1; }
done

echo "Smoke check passed"
