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
  'Итоги недели и ключевые проекты' \
  '532' \
  '81,02%' \
  'готовимся к тестированию' \
  'визуальная сборка' \
  'Что сделано' \
  'Что в работе' \
  'Что требуется от руководителей'; do
  grep -q "$needle" "$FILE" || { echo "Missing: $needle"; exit 1; }
done

for needle in \
  '431 решено в срок' \
  '101 с превышением' \
  '80,00%' \
  '81,70%' \
  'canvas id="incidentsChart"' \
  'new Chart('; do
  grep -q "$needle" "$FILE" || { echo "Missing: $needle"; exit 1; }
done

for needle in \
  'Назначить тестовую команду' \
  'база разработки' \
  'Готов переходить к первичному тестированию размещения' \
  'https://docs.google.com/spreadsheets/d/1CZ-ygVjbFeDR7BgL9zayrUSIvyO-gr-FetGvewdDqZE/edit?gid=2137234415#gid=2137234415' \
  'w-study.ru' \
  'w-stom.ru (старый)' \
  'w-stom.ru (новый)'; do
  grep -q "$needle" "$FILE" || { echo "Missing: $needle"; exit 1; }
done

echo "Smoke check passed"
