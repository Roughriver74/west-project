# Weekly IT Executive Report Visual Refresh Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refresh `20-04-2026.html` so it presents the week in a more visual, metrics-heavy format with a dedicated ABC block and a compact warehouse Gantt.

**Architecture:** Keep the report as one static HTML file and one smoke-test shell script. Update the existing layout in place: compress text-heavy sections, add one new `ABC` section, replace the text-only weekly focus with metric cards, and add a lightweight Gantt-like timeline for warehouse stages using plain HTML/CSS rather than an external charting dependency.

**Tech Stack:** Static HTML, Tailwind CDN, Chart.js CDN, plain JavaScript, Bash smoke test

---

## File map

- Modify: `20-04-2026.html`
  Add the ABC block, weekly results dashboard, compact warehouse Gantt, and lighter text layout while preserving the existing style system.
- Modify: `tests/20-04-2026-smoke.sh`
  Expand assertions to cover the new ABC metrics, weekly metrics, and compact warehouse Gantt labels.
- Reference: `docs/superpowers/specs/2026-04-20-it-weekly-exec-report-visual-refresh-design.md`
  Approved refresh spec.
- Reference: `Отчёт_IT_неделя_13-17_апреля.docx`, `Описание_ABCКлиентов.docx`, `Диаграмма_Ганта (1).xlsx`
  Source material for content and dates.

### Task 1: Update smoke coverage for the refreshed page structure

**Files:**
- Modify: `tests/20-04-2026-smoke.sh`
- Test: `tests/20-04-2026-smoke.sh`

- [ ] **Step 1: Replace the current smoke test body with stricter checks**

Replace the contents of `tests/20-04-2026-smoke.sh` with:

```bash
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
```

- [ ] **Step 2: Run the test to verify it fails against the old page**

Run:

```bash
bash tests/20-04-2026-smoke.sh
```

Expected: FAIL on `id="abc"` or another new needle because the page has not been refreshed yet.

- [ ] **Step 3: Commit the red-phase smoke update**

Run:

```bash
git add tests/20-04-2026-smoke.sh
git commit -m "test: expand smoke checks for visual refresh"
```

### Task 2: Rebuild the top of the page around metrics and ABC

**Files:**
- Modify: `20-04-2026.html`
- Test: `tests/20-04-2026-smoke.sh`

- [ ] **Step 1: Replace the current `#overview` and `#focus` blocks**

In `20-04-2026.html`, remove the existing `#focus` section completely and replace the current top section flow with:

- `#overview` containing:
  - shorter hero text;
  - 5 KPI cards instead of the current 4;
  - one KPI card dedicated to `ABC в 1С`.
- new `#abc` section immediately after `#overview`.
- new `#results` section immediately after `#abc`.

Use this exact content for the new sections:

```html
<section id="overview" class="space-y-8">
  <div class="rounded-3xl bg-gradient-to-r from-stone-800 to-stone-600 p-8 text-white shadow-xl">
    <p class="text-sm font-semibold uppercase tracking-[0.25em] text-stone-200">Executive summary</p>
    <h2 class="mt-3 text-3xl font-bold sm:text-4xl">Неделя с переходом от задач к внедрению</h2>
    <p class="mt-4 max-w-4xl text-lg leading-relaxed text-stone-100">
      Ключевые темы недели: завершён первый этап ABC-классификации клиентов в 1С, складовой проект вышел к старту тестирования, по сайту команда перешла к подготовке визуальной сборки.
    </p>
    <div class="mt-6 flex flex-wrap gap-4 text-sm text-stone-200">
      <span>📅 Период: 13–20 апреля 2026</span>
      <span>📊 43 задачи в недельном контуре</span>
      <span>🚚 3 ключевых направления недели</span>
    </div>
  </div>

  <div class="grid gap-6 sm:grid-cols-2 xl:grid-cols-5">
    <article class="rounded-2xl border-t-4 border-blue-500 bg-white p-6 shadow-lg">
      <p class="text-5xl font-bold text-stone-800">43</p>
      <p class="mt-2 font-medium text-stone-600">Задачи недели</p>
      <p class="mt-3 text-sm text-stone-500">23 выполнено, 15 в работе</p>
    </article>
    <article class="rounded-2xl border-t-4 border-emerald-500 bg-white p-6 shadow-lg">
      <p class="text-5xl font-bold text-stone-800">81,02%</p>
      <p class="mt-2 font-medium text-stone-600">Общий SLA</p>
      <p class="mt-3 text-sm text-stone-500">Нагрузка выросла, SLA удержан</p>
    </article>
    <article class="rounded-2xl border-t-4 border-violet-500 bg-white p-6 shadow-lg">
      <p class="text-2xl font-bold text-stone-800">ABC в 1С</p>
      <p class="mt-2 font-medium text-stone-600">Этап 1 завершён</p>
      <p class="mt-3 text-sm text-stone-500">Этап 2 на неделе, автоматизация следом</p>
    </article>
    <article class="rounded-2xl border-t-4 border-amber-500 bg-white p-6 shadow-lg">
      <p class="text-2xl font-bold text-stone-800">Склад</p>
      <p class="mt-2 font-medium text-stone-600">готовимся к тестированию</p>
      <p class="mt-3 text-sm text-stone-500">Нужна тестовая команда и доступы</p>
    </article>
    <article class="rounded-2xl border-t-4 border-fuchsia-500 bg-white p-6 shadow-lg">
      <p class="text-2xl font-bold text-stone-800">Сайт</p>
      <p class="mt-2 font-medium text-stone-600">визуальная сборка</p>
      <p class="mt-3 text-sm text-stone-500">Шаблон, лицензия и макет в работе</p>
    </article>
  </div>
</section>

<section id="abc" class="space-y-6">
  <div class="flex flex-col gap-3 lg:flex-row lg:items-end lg:justify-between">
    <div>
      <p class="text-sm font-semibold uppercase tracking-[0.25em] text-stone-500">1С / ERP</p>
      <h2 class="mt-2 text-3xl font-bold text-stone-800">ABC-клиенты в 1С</h2>
    </div>
    <span class="inline-flex w-fit rounded-full bg-violet-100 px-4 py-2 text-sm font-semibold text-violet-800">Приоритет недели</span>
  </div>

  <div class="grid gap-6 lg:grid-cols-[1.2fr_0.8fr]">
    <article class="rounded-3xl bg-white p-8 shadow-xl">
      <p class="max-w-3xl text-stone-700">
        Реализуется автоматическая сегментация клиентов по валовой прибыли с отображением категории в карточке клиента, историей изменений, подсказками в документах и регламентным расчётом.
      </p>

      <div class="mt-8 grid gap-4 md:grid-cols-3">
        <div class="rounded-2xl bg-violet-50 p-5">
          <p class="text-sm font-semibold text-violet-700">Этап 1 завершён</p>
          <p class="mt-2 text-sm text-stone-700">Регистр, карточка клиента, роль и базовое отображение закрыты.</p>
        </div>
        <div class="rounded-2xl bg-amber-50 p-5">
          <p class="text-sm font-semibold text-amber-700">Этап 2 на неделе</p>
          <p class="mt-2 text-sm text-stone-700">Подсказки, блокировки и правила в документах выходят следующим шагом.</p>
        </div>
        <div class="rounded-2xl bg-stone-100 p-5">
          <p class="text-sm font-semibold text-stone-700">Автоматизация в очереди</p>
          <p class="mt-2 text-sm text-stone-700">Регзадание и автопростановка категории ожидаются к концу недели или началу следующей.</p>
        </div>
      </div>

      <div class="mt-8">
        <div class="mb-3 flex items-center justify-between text-sm font-semibold text-stone-600">
          <span>Прогресс по этапам</span>
          <span>1 из 3 этапов закрыт</span>
        </div>
        <div class="h-4 overflow-hidden rounded-full bg-stone-200">
          <div class="h-full rounded-full bg-gradient-to-r from-violet-600 to-violet-400" style="width: 33.33%"></div>
        </div>
      </div>
    </article>

    <aside class="rounded-3xl bg-gradient-to-br from-violet-700 to-stone-800 p-8 text-white shadow-xl">
      <p class="text-sm font-semibold uppercase tracking-[0.25em] text-violet-200">Текущий статус</p>
      <div class="mt-6 space-y-4">
        <div class="rounded-2xl bg-white/10 p-4">
          <p class="text-sm text-violet-100">Этап</p>
          <p class="mt-1 text-2xl font-bold">1 / 3</p>
        </div>
        <div class="rounded-2xl bg-white/10 p-4">
          <p class="text-sm text-violet-100">Расчёт</p>
          <p class="mt-1 text-base font-semibold">по валовой прибыли за 100 дней</p>
        </div>
        <div class="rounded-2xl bg-white/10 p-4">
          <p class="text-sm text-violet-100">Ближайший результат</p>
          <p class="mt-1 text-base font-semibold">вторая итерация на этой неделе</p>
        </div>
      </div>
    </aside>
  </div>
</section>

<section id="results" class="space-y-6">
  <div class="text-center">
    <p class="text-sm font-semibold uppercase tracking-[0.25em] text-stone-500">Результаты недели</p>
    <h2 class="mt-2 text-3xl font-bold text-stone-800">Что сделал отдел за 13–17 апреля</h2>
  </div>

  <div class="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
    <article class="rounded-3xl bg-white p-6 shadow-xl">
      <p class="text-sm font-semibold uppercase tracking-wide text-stone-500">Задачи</p>
      <div class="mt-4 grid grid-cols-2 gap-3 text-sm">
        <div class="rounded-2xl bg-stone-50 p-4"><div class="text-3xl font-bold text-stone-800">23</div><div class="mt-1 text-stone-600">Выполнено</div></div>
        <div class="rounded-2xl bg-stone-50 p-4"><div class="text-3xl font-bold text-stone-800">15</div><div class="mt-1 text-stone-600">В работе</div></div>
        <div class="rounded-2xl bg-stone-50 p-4"><div class="text-3xl font-bold text-stone-800">3</div><div class="mt-1 text-stone-600">Заблокировано</div></div>
        <div class="rounded-2xl bg-stone-50 p-4"><div class="text-3xl font-bold text-stone-800">2</div><div class="mt-1 text-stone-600">Запланировано</div></div>
      </div>
    </article>

    <article class="rounded-3xl bg-white p-6 shadow-xl">
      <p class="text-sm font-semibold uppercase tracking-wide text-stone-500">База 1С</p>
      <p class="mt-4 text-4xl font-bold text-stone-800">230 Гб → 140 Гб</p>
      <p class="mt-3 text-sm text-stone-600">Вложения вынесены на диск, снят риск нехватки места под резервные копии.</p>
    </article>

    <article class="rounded-3xl bg-white p-6 shadow-xl">
      <p class="text-sm font-semibold uppercase tracking-wide text-stone-500">Bitrix24</p>
      <div class="mt-4 space-y-3">
        <div class="rounded-2xl bg-stone-50 p-4">
          <div class="text-3xl font-bold text-stone-800">400–500</div>
          <div class="mt-1 text-sm text-stone-600">дублей контактов обработано</div>
        </div>
        <div class="rounded-2xl bg-stone-50 p-4">
          <div class="text-3xl font-bold text-stone-800">2000</div>
          <div class="mt-1 text-sm text-stone-600">старых сделок обработано по ортодонтии</div>
        </div>
      </div>
    </article>

    <article class="rounded-3xl bg-white p-6 shadow-xl">
      <p class="text-sm font-semibold uppercase tracking-wide text-stone-500">Склад и аналитика</p>
      <div class="mt-4 space-y-3">
        <div class="rounded-2xl bg-stone-50 p-4">
          <div class="text-base font-semibold text-stone-800">KPI для сборщиков</div>
          <div class="mt-1 text-sm text-stone-600">завершён и сдан</div>
        </div>
        <div class="rounded-2xl bg-stone-50 p-4">
          <div class="text-base font-semibold text-stone-800">QR-код</div>
          <div class="mt-1 text-sm text-stone-600">склад тестировал задание уже 2 дня</div>
        </div>
      </div>
    </article>
  </div>
</section>
```

- [ ] **Step 2: Run the smoke test and verify it passes**

Run:

```bash
bash tests/20-04-2026-smoke.sh
```

Expected: PASS with `Smoke check passed`.

- [ ] **Step 3: Commit the top-half refresh**

Run:

```bash
git add 20-04-2026.html tests/20-04-2026-smoke.sh
git commit -m "feat: add ABC and weekly results dashboard"
```

### Task 3: Add the compact warehouse Gantt and simplify project sections

**Files:**
- Modify: `20-04-2026.html`
- Test: `tests/20-04-2026-smoke.sh`

- [ ] **Step 1: Rebuild the `#warehouse` section around a compact Gantt**

In `20-04-2026.html`, keep the current warehouse header and callout, but replace the current month-card grid with:

```html
<div class="mt-8 overflow-hidden rounded-3xl border border-stone-200">
  <div class="grid grid-cols-[1.1fr_repeat(3,0.8fr)] bg-stone-100 text-xs font-semibold uppercase tracking-wide text-stone-500">
    <div class="px-4 py-3">Этап</div>
    <div class="px-4 py-3">Апрель</div>
    <div class="px-4 py-3">Май</div>
    <div class="px-4 py-3">Июнь</div>
  </div>

  <div class="divide-y divide-stone-200 bg-white">
    <div class="grid grid-cols-[1.1fr_repeat(3,0.8fr)] items-center">
      <div class="px-4 py-4 font-medium text-stone-800">Подготовка</div>
      <div class="px-4 py-4"><div class="h-3 rounded-full bg-amber-400"></div></div>
      <div class="px-4 py-4"></div>
      <div class="px-4 py-4"></div>
    </div>
    <div class="grid grid-cols-[1.1fr_repeat(3,0.8fr)] items-center">
      <div class="px-4 py-4 font-medium text-stone-800">Разработка</div>
      <div class="px-4 py-4"><div class="h-3 rounded-full bg-stone-400"></div></div>
      <div class="px-4 py-4"><div class="h-3 rounded-full bg-stone-400"></div></div>
      <div class="px-4 py-4"></div>
    </div>
    <div class="grid grid-cols-[1.1fr_repeat(3,0.8fr)] items-center">
      <div class="px-4 py-4 font-medium text-stone-800">Тестирование</div>
      <div class="px-4 py-4"></div>
      <div class="px-4 py-4"><div class="h-3 rounded-full bg-emerald-500"></div></div>
      <div class="px-4 py-4"></div>
    </div>
    <div class="grid grid-cols-[1.1fr_repeat(3,0.8fr)] items-center">
      <div class="px-4 py-4 font-medium text-stone-800">Доработка</div>
      <div class="px-4 py-4"></div>
      <div class="px-4 py-4"><div class="h-3 rounded-full bg-fuchsia-400"></div></div>
      <div class="px-4 py-4"><div class="h-3 rounded-full bg-fuchsia-400"></div></div>
    </div>
    <div class="grid grid-cols-[1.1fr_repeat(3,0.8fr)] items-center">
      <div class="px-4 py-4 font-medium text-stone-800">Эксплуатация</div>
      <div class="px-4 py-4"></div>
      <div class="px-4 py-4"></div>
      <div class="px-4 py-4"><div class="h-3 rounded-full bg-cyan-500"></div></div>
    </div>
    <div class="grid grid-cols-[1.1fr_repeat(3,0.8fr)] items-center">
      <div class="px-4 py-4 font-medium text-stone-800">Завершение</div>
      <div class="px-4 py-4"></div>
      <div class="px-4 py-4"></div>
      <div class="px-4 py-4"><div class="h-3 rounded-full bg-stone-700"></div></div>
    </div>
  </div>
</div>
```

Immediately above the Gantt, replace the long status paragraph with:

```html
<div class="mt-4 grid gap-4 md:grid-cols-3">
  <div class="rounded-2xl bg-stone-50 p-4">
    <p class="text-sm font-semibold text-stone-500">Текущий этап</p>
    <p class="mt-2 text-base font-semibold text-stone-800">Готов переходить к первичному тестированию размещения</p>
  </div>
  <div class="rounded-2xl bg-stone-50 p-4">
    <p class="text-sm font-semibold text-stone-500">Среда</p>
    <p class="mt-2 text-base font-semibold text-stone-800">база разработки</p>
  </div>
  <div class="rounded-2xl bg-stone-50 p-4">
    <p class="text-sm font-semibold text-stone-500">Следующее решение</p>
    <p class="mt-2 text-base font-semibold text-stone-800">назначить тестовую команду</p>
  </div>
</div>
```

- [ ] **Step 2: Shorten the website section copy without removing the CTA**

In `20-04-2026.html`, keep the current website structure, but replace the three project paragraphs with these shorter texts:

```html
<p class="mt-4 text-stone-700">Критичные ошибки старого сайта закрыты.</p>
<p class="mt-4 text-stone-700">По новому сайту запрошены счёт и лицензия, разработчик получил референсы на макет.</p>
<p class="mt-4 text-stone-700">По учебному центру подтверждены оплата и передача записи в Bitrix24, команда переходит к визуальной части.</p>
```

- [ ] **Step 3: Run the smoke test and verify it still passes**

Run:

```bash
bash tests/20-04-2026-smoke.sh
```

Expected: PASS with `Smoke check passed`.

- [ ] **Step 4: Commit the project-section refresh**

Run:

```bash
git add 20-04-2026.html
git commit -m "feat: add compact warehouse gantt"
```

### Task 4: Final polish, visual QA, and deployment-ready verification

**Files:**
- Modify: `20-04-2026.html`
- Test: `tests/20-04-2026-smoke.sh`

- [ ] **Step 1: Remove obsolete nav entry if needed**

If the page still contains a nav link to `#focus`, replace the nav block in `20-04-2026.html` with:

```html
<nav class="sticky top-0 z-20 mb-8 border-b border-stone-300 bg-white/90 shadow-sm backdrop-blur-md">
  <div class="flex justify-center overflow-x-auto px-4">
    <a href="#overview" class="nav-link border-b-2 border-transparent px-3 py-4 text-sm font-semibold text-stone-600">Обзор</a>
    <a href="#abc" class="nav-link border-b-2 border-transparent px-3 py-4 text-sm font-semibold text-stone-600">ABC</a>
    <a href="#results" class="nav-link border-b-2 border-transparent px-3 py-4 text-sm font-semibold text-stone-600">Результаты</a>
    <a href="#incidents" class="nav-link border-b-2 border-transparent px-3 py-4 text-sm font-semibold text-stone-600">Инциденты</a>
    <a href="#warehouse" class="nav-link border-b-2 border-transparent px-3 py-4 text-sm font-semibold text-stone-600">Склад</a>
    <a href="#website" class="nav-link border-b-2 border-transparent px-3 py-4 text-sm font-semibold text-stone-600">Сайт</a>
    <a href="#decisions" class="nav-link border-b-2 border-transparent px-3 py-4 text-sm font-semibold text-stone-600">Решения</a>
  </div>
</nav>
```

- [ ] **Step 2: Run automated verification**

Run:

```bash
bash tests/20-04-2026-smoke.sh
```

Expected: PASS with `Smoke check passed`.

- [ ] **Step 3: Run visual verification**

Run:

```bash
'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --headless=new --disable-gpu --hide-scrollbars --window-size=1440,5000 --screenshot='/tmp/it-report-refresh-desktop.png' 'file://$(pwd)/20-04-2026.html'
'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --headless=new --disable-gpu --hide-scrollbars --window-size=430,5000 --screenshot='/tmp/it-report-refresh-mobile.png' 'file://$(pwd)/20-04-2026.html'
```

Expected:

- desktop screenshot shows ABC block, results block, incidents, warehouse Gantt, website, and decisions without clipping;
- mobile screenshot shows stacked cards, readable Gantt labels, and visible CTA button.

- [ ] **Step 4: Commit the final refresh**

Run:

```bash
git add 20-04-2026.html tests/20-04-2026-smoke.sh
git commit -m "feat: refresh weekly IT report visuals"
```
