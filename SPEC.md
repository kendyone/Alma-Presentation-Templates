# Presentation Skill — Specifikace

> Living document. Aktualizuj při každé změně. Slouží jako kontext bridge mezi konverzacemi.

---

## 1. Co skill dělá

Uživatel popíše téma a dodá data → Claude vybere vhodné slide šablony → vyplní je obsahem → výstup je jeden self-contained HTML soubor (prezentace).

**Zásady:**
- Každá šablona má jasně definovaný typ obsahu, pro který smí být použita
- Claude nesmí použít šablonu pro jiný typ obsahu, než pro který je určena (např. graf ≠ citace)
- Výstup je vždy single HTML soubor, slidy jako `<section>`, navigace šipkami, 1920×1080 fixed stage

---

## 2. Brand — Design tokens

### Barvy

```css
/* Neutrály */
--color-primary-black:    #1D1D1D;
--color-secondary-black:  #57575B;
--color-bg-primary:       #FFFDFD;

/* Akcenty */
--color-accent-yellow:    #FFCB3B;
--color-accent-orange:    #FD7E40;
--color-accent-turquoise: #4DD7BE;
--color-accent-violet:    #8F66FF;
```

### Typografie

Fonty: **Newsreader** (serif, SemiBold 600) · **Inter** (sans, Regular 400 / Bold 700)

```css
--type-display:          font: 600 90px/98px 'Newsreader', serif;
--type-screen-headline:  font: 600 64px/64px 'Newsreader', serif;
--type-screen-subtitle:  font: 400 32px/44px 'Inter', sans-serif;
--type-stats-default:    font: 600 90px/90px 'Newsreader', serif;
--type-stats-graph:      font: 600 56px/56px 'Newsreader', serif;
--type-body-xl-bold:     font: 700 34px/48px 'Inter', sans-serif;
--type-body-xl-regular:  font: 400 34px/48px 'Inter', sans-serif;
--type-body-md-bold:     font: 700 24px/34px 'Inter', sans-serif;
--type-body-md-regular:  font: 400 24px/34px 'Inter', sans-serif;
```

### Spacing & layout

```css
--canvas-width:   1920px;
--canvas-height:  1080px;
--padding-v:      72px;
--padding-h:      80px;
--gap-headline-subtitle: 16px;
```

---

## 3. Slide šablony

### Layout_01_BarChart_Ascending

**File:** `templates/layout-01-barchart-ascending.html`

**When to use:**
- 2–4 data points representing ratios, distributions, or progress in percentages.
- Data points are comparable in nature (visual comparison makes sense).

**Allowed content:**
- 1× Headline (max 40 chars), 1× Subtitle
- 2–4 columns, each with: value (strictly `% only`, e.g. `21 %`) + description (max 100 chars)

**Forbidden:** currencies, absolute numbers, time units, more than 4 or fewer than 2 data points.

**Scaling logic:**
- Highest value = 100 % of `MAX_BAR_HEIGHT` (480px)
- Other values = `(value / maxValue) * MAX_BAR_HEIGHT`
- Total column height (bar + text + gap) must not exceed 756px

---

### Layout_02_HeroMetrics_Tiles

**File:** `templates/layout-02-hero-metrics-tiles.html`

**When to use:**
- 2 or 3 key metrics that are semantically different (e.g. revenue vs. progress vs. user count).
- Designed for DIFFERENT types of data side by side (e.g. € next to % next to a date).

**Allowed content:**
- 1× Headline (max 40 chars), 1× Subtitle
- 2–3 tiles, each with:
  - Main value: max 10 chars — `21 000 €`, `21 %`, `600+`, `Q4 2026`. No words.
  - Tile headline: max 30 chars
  - Tile description: max 150 chars

**Tile color system (fixed):**
| Slot | Background | Stat color | Use when |
|------|-----------|------------|----------|
| Peach | `#FFE5D9` | `#72371A` | 3-tile only (slot 1) |
| Mint | `#DBF7F2` | `#1F564C` | slot 1 (2-tile) or slot 2 (3-tile) |
| Lavender | `#E9E0FF` | `#432989` | always last slot |

2 tiles → Mint + Lavender · 3 tiles → Peach + Mint + Lavender

**Forbidden:** words inside main value, paragraphs/lists in description, fewer than 2 or more than 3 tiles, time series of same metric.

---

### Layout_03_GridMetrics_4Tiles

**File:** `templates/layout-03-grid-metrics-4tiles.html`

**When to use:** Exactly 4 different but related metrics or KPIs.

**Allowed content:**
- 1× Headline (max 40 chars), 1× Subtitle
- Exactly 4 tiles, each with: main value max 10 chars, headline max 30 chars, description max 120 chars.

**Forbidden:** words inside main value, sentences/lists inside tiles, fewer or more than 4 metrics.

---

### Layout_04_GridMetrics_6Tiles

**File:** `templates/layout-04-grid-metrics-6tiles.html`

**When to use:** 5 or 6 metrics/KPIs. With 5 metrics: 6th tile rendered as blank lavender tile.

**Allowed content:**
- 1× Headline (max 40 chars), 1× Subtitle
- 5–6 tiles, each with: main value max 10 chars, headline max 25 chars, description max 80 chars (strictly 1 line).

**Forbidden:** more than 1 description line, sentences/lists, words inside main value, fewer than 5 or more than 6 metrics.

---

### Layout_05_ProgressBars_Simple

**File:** `templates/layout-05-progress-bars-simple.html`

**When to use:** Exactly 4 comparable items as horizontal progress bars.

**Allowed content:**
- 1× Headline (max 40 chars), 1× Subtitle
- Exactly 4 rows: label (max 30 chars) + value (strictly `%` only, e.g. `70 %`)

**Forbidden:** delta values (use Layout_06), non-percentage data, more or fewer than 4 rows.

**Bar fill:** `value / 100 × 100%` of track width — strictly proportional, no hardcoded widths.
Track bg: `#E9E0FF` · Fill: `#8F66FF`

---

### Layout_06_ProgressBars_WithVariance

**File:** `templates/layout-06-progress-bars-variance.html`

**When to use:** Exactly 4 items, each with a final value AND a comparative delta.

**Allowed content:**
- 1× Headline (max 40 chars), 1× Subtitle
- Exactly 4 rows: label (max 30 chars) + variance (signed `%`, positive → green `#2E8172`, negative → red `#A02626`) + final value (`%` only)

**Forbidden:** missing variance for any row, sentences/paragraphs, non-percentage data.

**Bar fill:** `finalValue / 100 × 1297px` — strictly proportional.
Track bg: `#FFE5D9` · Fill: `#FD7E40`

---

### Layout_07_Quote_Dark

**File:** `templates/layout-07-quote-dark.html`

**When to use:** Direct quote, testimonial, or strong standalone claim.

**Allowed content:**
- 1× Profile photo or icon — optional
- 1× Quote text: max 450 chars. Font scales by length:
  - ≤ 80 chars → 90px · ≤ 150 chars → 72px · ≤ 250 chars → 64px · ≤ 450 chars → 54px
- 1× Author / source — optional

**Forbidden:** more than one text block, lists, charts, numbers, text longer than 450 chars.

---

### Layout_08_Section_Divider

**File:** `templates/layout-08-section-divider.html`

**When to use:** Starting a new chapter/section, visual break between content-heavy slides, strong standalone claim.

**Allowed content:**
- 1× Eyebrow: max 40 chars — optional
- 1× Headline: max 60 chars
- 1× Supporting paragraph: max 250 chars — optional

**Color themes (`data-theme` on `.divider-card`):**
| Theme | Card bg | Headline | Body |
|---|---|---|---|
| `dark` (default) | `#1D1D1D` | `#FFFFFF` | `#A1A1A1` |
| `yellow` | `#FFCB3B` | `#1D1D1D` | `#57575B` |
| `violet` | `#8F66FF` | `#FFFFFF` | `rgba(255,255,255,0.7)` |

**Forbidden:** bullet lists, tiles, icons, photos, supporting text longer than 250 chars, multiple text blocks.

---

### Layout_09_Brand_Claim_Centered

**File:** `templates/layout-09-brand-claim-centered.html`

**When to use:** Maximum visual emphasis on a single short idea — slogan, brand value, or claim that stands alone.

**Allowed content:**
- 1× Eyebrow: max 40 chars — optional
- 1× Claim: max 80 chars

**Color themes (`data-theme` on `.claim-card`):**
| Theme | Card bg | Headline | Eyebrow |
|---|---|---|---|
| `dark` (default) | `#1D1D1D` | `#FFFFFF` | `rgba(255,255,255,0.65)` |
| `yellow` | `#FFCB3B` | `#1D1D1D` | `rgba(0,0,0,0.5)` |
| `turquoise` | `#4DD7BE` | `#1D1D1D` | `rgba(0,0,0,0.5)` |
| `violet` | `#8F66FF` | `#FFFFFF` | `rgba(255,255,255,0.65)` |
| `orange` | `#FD7E40` | `#1D1D1D` | `rgba(0,0,0,0.5)` |

**Forbidden:** body paragraph, icons, photos, lists, metrics, more than one content block, text longer than 80 chars.

---

### Layout_10_Presentation_Intro

**File:** `templates/layout-10-presentation-intro.html`

**When to use:** First slide or opening of a new major topic block with exactly 1 speaker.

**Allowed content:**
- 1× Headline: max 60 chars
- 1× Description: max 250 chars
- 1× Speaker name: max 30 chars, role: max 30 chars
- 1× Profile photo — optional (remove `<img>` if unavailable)

**Color themes (`data-theme` on `.intro-card`):**
| Theme | Card bg | Headline / Name | Description / Role |
|---|---|---|---|
| `violet` (default) | `#8F66FF` | `#1D1D1D` | `#3A3A3D` |
| `yellow` | `#FFCB3B` | `#1D1D1D` | `#3A3A3D` |
| `turquoise` | `#4DD7BE` | `#1D1D1D` | `#3A3A3D` |
| `orange` | `#FD7E40` | `#1D1D1D` | `#3A3A3D` |
| `dark` | `#1D1D1D` | `#FFFFFF` | `rgba(255,255,255,0.65)` |

**Forbidden:** bullet lists, charts, metrics, description longer than 250 chars, more than 1 speaker.

---

### Layout_11_Presentation_Intro_MultiSpeaker

**File:** `templates/layout-11-presentation-intro-multispeaker.html`

**When to use:** Intro slide with 2–4 speakers. For 1 speaker use Layout_10.

**Allowed content:**
- 1× Headline: max 60 chars
- 1× Description: max 200 chars (shorter than Layout_10 — grid takes space)
- 2–4 speaker blocks: name max 25 chars, role max 25 chars, photo optional

**Color themes (`data-theme` on `.intro-card`):** same table as Layout_10.

**Forbidden:** more than 4 speakers, bios in speaker cards, description longer than 200 chars.

---

### Layout_12_Bullet_Points_List

**File:** `templates/layout-12-bullet-points-list.html`

**When to use:** List of features, advantages, benefits, or summary steps (1–7 items), each fitting one sentence.

**Allowed content:**
- 1× Headline + 1× Subtitle (max 150 chars)
- 1–7 bullet rows: text max 120 chars, one sentence. Optional `<strong>` for first 3–4 words.

**Forbidden:** more than 7 bullets, multiple sentences per bullet, nested bullets, charts, metrics.

---

### Layout_13_Bullet_Points_Double_Column

**File:** `templates/layout-13-bullet-points-double-column.html`

**When to use:** 5–10 short bullets. Fewer than 5 → Layout_12. More than 10 → split slides.

**Allowed content:**
- 1× Headline + 1× Subtitle
- 5–10 bullets split evenly (e.g. 4+4, 5+5, 5+4), each max 80 chars.
- Odd last bullet: add `.bullet-col.bullet-col--empty` as second cell.

**Forbidden:** fewer than 5 or more than 10, complex sentences, charts, asymmetric splits.

---

### Layout_14_Bullet_Points_Double_Column_With_Titles

**File:** `templates/layout-14-bullet-points-double-column-with-titles.html`

**When to use:** 4–8 items where a bold label + description adds clarity. Plain list → Layout_13. Fewer than 4 → Layout_12.

**Allowed content:**
- 1× Headline + 1× Subtitle
- 4–8 items split evenly, each with: title max 35 chars + description max 120 chars.
- Odd last item: add `.item-col.item-col--empty` as second cell.

**Forbidden:** fewer than 4 or more than 8, long paragraphs, asymmetric splits, images/charts.

---

### Layout_15_Image_Left_Text_Right

**File:** `templates/layout-15-image-left-text-right.html`

**When to use:** Strong relevant photo paired with a headline or short story (vision, team, environment).

**Allowed content:**
- 1× Photo (`object-fit: cover`)
- 1× Headline: max 60 chars (no top header bar in this layout)
- 1× Body text: max 300 chars — optional

**Forbidden:** bullet lists, charts, more than one photo, body longer than 300 chars.

---

### Layout_16_Text_Left_Image_Right

**File:** `templates/layout-16-text-left-image-right.html`

**When to use:** Same as Layout_15 — alternate between L15 and L16 across consecutive slides for visual rhythm.

**Allowed content:** same as Layout_15 — headline max 60 chars, body max 300 chars optional, 1× photo.

**Forbidden:** same as Layout_15.

---

### Layout_17_Text_3_Columns

**File:** `templates/layout-17-text-3-columns.html`

**When to use:** Exactly 3 related topics, pillars, or areas. For 2 columns → Layout_18.

**Allowed content:**
- 1× Headline + 1× Subtitle
- Exactly 3 columns: title max 40 chars (`min-height: 144px` = 3 lines), body max 250 chars.

**Forbidden:** bullet lists, images, metrics inside columns, body longer than 250 chars, fewer or more than 3 columns.

---

### Layout_18_Text_2_Columns

**File:** `templates/layout-18-text-2-columns.html`

**When to use:** Exactly 2 comparable topics. For 3 → Layout_17. For 1 → Layout_12.

**Allowed content:**
- 1× Headline + 1× Subtitle
- Exactly 2 columns: title max 50 chars (`min-height: 96px` = 2 lines), body max 350 chars.

**Forbidden:** bullet lists, tables, images, charts, body longer than 350 chars, fewer or more than 2 columns.

---

### Layout_19_Text_2_Columns_Flexible

**File:** `templates/layout-19-text-2-columns-flexible.html`

**When to use:** 2–4 text blocks (2 columns × 1–2 rows) with varying content length. 1 `.col-row` for 2 blocks, 2 `.col-rows` for 3–4. For 2 similar-length blocks consider Layout_18.

**Allowed content:**
- 1× Headline + 1× Subtitle
- Per cell: title max 80 chars (`min-height: 96px`), body max 250 chars.

**Forbidden:** lists, images, charts, more than 4 blocks.

---

### Layout_20_Icon_Grid_2to4

**File:** `templates/layout-20-icon-grid-2to4.html`

**When to use:** 2–4 items each with a distinct icon. Fewer than 2 or more than 4 → different layout.

**Allowed content:**
- 1× Headline + 1× Subtitle
- Per card: icon in `.icon-box`, title max 60 chars, body max 200 chars.
- Icon colors: `.icon-box--violet` · `.icon-box--turquoise` · `.icon-box--orange` · `.icon-box--yellow`

**Rows:** 2 items → 1 `.icon-row` · 3 items → 2 rows (second has 1 card) · 4 items → 2 full rows

**Forbidden:** bullet lists in body, photos, charts, more than 4 cards.

---

### Layout_21_Team_Cards_Horizontal

**File:** `templates/layout-21-team-cards-horizontal.html`

**When to use:** 2–4 people, photo as dominant element. More than 4 → Layout_22.

**Allowed content:**
- 1× Headline + 1× Subtitle
- Per card: photo (`.photo` div → `<img>`), name max 30 chars, role max 50 chars.
- Cards use `flex: 1` — auto-width: 2 = 852px, 3 = 549px, 4 = 398px.

**Forbidden:** biographical text, lists in cards, more than 4 people.

---

### Layout_22_Team_List_Grid

**File:** `templates/layout-22-team-list-grid.html`

**When to use:** 5–8 people. Fewer → Layout_21. More than 8 → split slides.

**Allowed content:**
- 1× Headline + 1× Subtitle
- Per person: photo (`.person-photo` div → `<img>`), name max 30 chars, role max 40 chars.

**Column split:** always even — `ceil(N/2)` left, `floor(N/2)` right.

**Scaling:**
- 5–6 people: default (`--photo: 180px`, `--rgap: 56px`)
- 7–8 people: set `style="--photo: 150px; --rgap: 40px;"` on `.persons-grid`

**Forbidden:** text beyond name+role, uneven column splits.

---

### Layout_23_Farewell_Single_Speaker

**File:** `templates/layout-23-farewell-single-speaker.html`

**When to use:** Final slide with exactly 1 speaker. For 2+ → Layout_24.

**Allowed content:**
- 1× Claim: max 60 chars
- 1× Illustration/photo: replace `.illustration` div with `<img>`
- 1× Name: max 30 chars, 1× Role: max 30 chars

**Forbidden:** body text, lists, charts, more than 1 speaker.

---

### Layout_24_Farewell_Multi_Speaker

**File:** `templates/layout-24-farewell-multi-speaker.html`

**When to use:** Final slide with 2–4 speakers. For 1 → Layout_23.

**Allowed content:**
- 1× Claim: max 50 chars
- Per speaker: photo (`.speaker-photo` div → `<img>`), name max 25 chars, role max 25 chars.
- Removing speakers: delete `.speaker-card` elements — grid auto-adjusts.

**Forbidden:** more than 4 speakers, biographical text, lists.

---

### Layout_25_Roadmap_Multi_Task_Per_Team

**File:** `templates/layout-25-roadmap-multi-task.html`

**When to use:** At least one team has 2+ tasks. If all teams have 1 task → Layout_26.

**Allowed content:**
- 1× Headline + 1× Subtitle, max 4 team rows.
- Per row: 2 task sub-rows, each task spanning 1–4 quarters.

**Quarter span classes:** `.q1` (370px) · `.q2` (740px) · `.q3` (1110px) · `.q4` (1480px)
**Color classes:** `.tc-yellow` `#FFCB3B` · `.tc-orange` `#FD7E40` · `.tc-turquoise` `#4DD7BE` · `.tc-violet` `#8F66FF`

**Task sub-row structure:**
```html
<div class="task-sub-row">
  <div class="empty-cell q1"></div>
  <div class="task-cell q2 tc-yellow">Label</div>
  <div class="empty-cell q1"></div>
</div>
```
Rule: spans within each sub-row must sum to `.q4` (1480px total).

**Forbidden:** hardcoded spans not matching real data, images, lists.

---

### Layout_26_Roadmap_Single_Task_Per_Team

**File:** `templates/layout-26-roadmap-single-task.html`

**When to use:** Every team has exactly 1 task. If any team has 2+ → Layout_25.

**Allowed content:**
- 1× Headline + 1× Subtitle, max 4 team rows.
- Per row: 1 task bar (`.task-cell`) + empty cells summing to `.q4` (1480px).

**Quarter spans:** `.q1` (370px) · `.q2` (740px) · `.q3` (1110px) · `.q4` (1480px)
**Colors:** `.tc-yellow` · `.tc-orange` · `.tc-turquoise` · `.tc-violet`

**Forbidden:** more than 1 task cell per row, mixed single/multi task rows.

---

### Pravidlo: automatická `min-height` pro nadpisy v řadách

Platí pro L17, L18, L19, L20 a podobné layouty s více sloupci:

AI odhadne počet řádků každého nadpisu, vezme maximum přes všechny v řadě a nastaví `min-height`:

| Max. řádků | `min-height` |
|---|---|
| 1 | `48px` |
| 2 | `96px` |
| 3 | `144px` |

---

### Layout_27_Donut_Chart_Metrics

**File:** `templates/layout-27-donut-chart-metrics.html`

**When to use:** 3–6 categories partitioning a whole (sum = 100%). Chart LEFT, legend RIGHT.

**Allowed content:**
- 1× Headline + 1× Subtitle
- 3–6 `.legend-item` blocks, each with `data-color` (hex) matching its segment.
- `legend-value` = percentage text (JS reads it to build the SVG).
- Description: max ~120 chars, up to 2 lines.
- Color order: yellow (#FFCB3B) · orange (#FD7E40) · turquoise (#4DD7BE) · violet (#8F66FF) · blue (#3B72FF) — use first N.
- Yellow uses `.c-yellow` class (#B78600); others use full-saturation color class.

**Forbidden:** fewer than 3 or more than 6 items, sum ≠ 100%, color mismatch.

---

### Layout_28_Pie_Chart_Metrics

**File:** `templates/layout-28-pie-chart-metrics.html`

**When to use:** 3–6 categories as proportional slices. Chart RIGHT, legend LEFT. Use over Layout_27 when body context text is needed and descriptions are short (1 line).

**Allowed content:**
- 1× Headline + 1× Subtitle
- Body text above legend: max ~200 chars
- 3–6 `.legend-item` blocks with `data-color` matching the segment.
- `legend-pct` = percentage text (parsed by JS); `legend-desc` = max ~30 chars, 1 line only.
- Color order: turquoise (#4DD7BE) · violet (#8F66FF) · blue (#3B72FF) · yellow (#FFCB3B) · orange (#FD7E40) — use first N.

**Forbidden:** fewer than 3 or more than 6 items, long descriptions (no wrapping), color mismatch.
