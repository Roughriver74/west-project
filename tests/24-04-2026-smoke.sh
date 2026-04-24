#!/usr/bin/env bash
set -euo pipefail

FILE="24-04-2026.html"

[[ -f "$FILE" ]] || { echo "Missing $FILE"; exit 1; }

for needle in \
  '20-24 апреля 2026' \
  'id="overview"' \
  'id="metrics"' \
  'id="work"' \
  'id="abc"' \
  'id="warehouse"' \
  'id="website"' \
  'id="decisions"' \
  '1159' \
  '216' \
  '81,04%' \
  '923' \
  '78,11%' \
  'ABC-клиенты в 1С' \
  'Клиенты без категории = класс C' \
  'Gantt по складу' \
  'Тестовая команда и база готовы' \
  'Обратная связь до 15 мая' \
  'Собрать и обработать обратную связь по размещению до 15 мая' \
  'Критичные ошибки закрыты' \
  'Готовится, будет на неделе' \
  'Digital-специалист' \
  'Оплата и Bitrix24 протестированы' \
  'https://docs.google.com/spreadsheets/d/1CZ-ygVjbFeDR7BgL9zayrUSIvyO-gr-FetGvewdDqZE/edit?gid=2137234415#gid=2137234415' \
  'assets/it-dashboard-2026-04-24.png'; do
  grep -q "$needle" "$FILE" || { echo "Missing: $needle"; exit 1; }
done

[[ -f "assets/it-dashboard-2026-04-24.png" ]] || { echo "Missing dashboard image"; exit 1; }

echo "Smoke check passed"
