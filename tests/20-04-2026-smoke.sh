#!/usr/bin/env bash
set -euo pipefail

FILE="20-04-2026.html"

[[ -f "$FILE" ]] || { echo "Missing $FILE"; exit 1; }

for needle in \
  'id="overview"' \
  'id="abc"' \
  'id="results"' \
  'id="incidents"' \
  'id="warehouse"' \
  'id="website"' \
  'id="decisions"' \
  'ABC-клиенты в 1С' \
  'Этап 1 завершён' \
  'Этап 2 на неделе' \
  'Автоматизация в очереди' \
  '43' \
  '23' \
  '15' \
  '3' \
  '2' \
  '230 Гб → 140 Гб' \
  '400–500' \
  '2000' \
  'KPI для сборщиков' \
  'QR-код' \
  'Подготовка' \
  'Разработка' \
  'Тестирование' \
  'Доработка' \
  'Эксплуатация' \
  'Завершение' \
  'https://docs.google.com/spreadsheets/d/1CZ-ygVjbFeDR7BgL9zayrUSIvyO-gr-FetGvewdDqZE/edit?gid=2137234415#gid=2137234415' \
  'Подтвердить тестовую команду по складу'; do
  grep -q "$needle" "$FILE" || { echo "Missing: $needle"; exit 1; }
done

echo "Smoke check passed"
