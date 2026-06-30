# Alma Presentation Generator

Your task is to generate a self-contained HTML presentation in the Alma Career design system style.

Work through three phases in order: **onboarding → content → generation**. Never skip phases.

**Before asking anything**, tell the user:
> Before we start — you can browse all available slide layouts at **localhost:4200/showcase.html** (open it in your browser while the server is running). It shows live previews of all 29 templates, so you can point me to specific ones if you like.

---

## Phase 1 — Onboarding

Ask questions **sequentially** — one question, wait for the answer, then move to the next. Never ask multiple questions at once.

### Question 1 — Title

Ask:
> What will the presentation be called? It will appear on the opening slide. If you're not sure, give me some context and I'll come up with a name.

Wait for the answer.

### Question 2 — Topic

Ask:
> What's the topic or occasion for this presentation? Feel free to go into detail — the more context I have, the better.

Wait for the answer.

### Question 3 — Presenters

Ask:
> Who will be presenting? Please share names and job titles — will it just be you, or are there multiple presenters?

Wait for the answer.

### Question 4 — Images

Ask:
> Will you be including any images? (presenter photos, logo, supporting visuals…)

**If yes:**
> Great. Drop them into the `presentation-skill/images/` folder — photos, logos, anything you need. Once they're there, just tell me the filenames (e.g. `jane-smith.jpg`) and I'll include them in the presentation.

Wait for confirmation of filenames.

**If no:**
Move on to the content question below.

---

After all four questions, ask about content delivery:
> Do you have all your content ready (text, data, stats) and want to hand it over at once — or would you prefer to go slide by slide together?

Then move to Phase 2.

---

## Phase 2 — Content

Before generating, make sure you have:

- [ ] Presentation title (for the opening slide + filename)
- [ ] Presenters (name, role, photo filename if applicable)
- [ ] All content (data, text, quotes, statistics)
- [ ] Presentation language (English / Czech)
- [ ] Approximate number of slides, or instruction to decide yourself

If anything is missing, ask for it. Once everything is clear, move to Phase 3.

---

## Phase 3 — Generation

### 3a. Read the SPEC

Read `presentation-skill/SPEC.md` — it contains all rules for selecting and filling slide templates.

### 3b. Propose the structure

Based on the content, propose a list of slides. Describe each slide **visually and by content** — what the user will see and what goes in it. Include the layout name only in parentheses as a technical reference.

Format:

```
1. Opening slide with two speakers — photos, name and role for each (Layout_11)
2. Full-screen large number with supporting text — main claim of the presentation (Layout_09)
3. Three key metrics side by side in tiles (Layout_02)
...
N. Closing slide with speaker contact info (Layout_23)
```

Present the structure to the user for approval. Wait for OK or adjustments.

### 3c. Read the templates

For each approved layout, read the corresponding file from `presentation-skill/templates/`.

### 3d. Build the output HTML

The output is a **single self-contained HTML file** with no external dependencies (except Google Fonts).

**Output structure:**

```html
<!DOCTYPE html>
<html lang="[cs|en]">
<head>
<meta charset="UTF-8">
<title>[presentation title]</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Newsreader:wght@600&family=Inter:wght@400;700&display=swap" rel="stylesheet">
<style>
  /* Reset */
  * { box-sizing: border-box; margin: 0; padding: 0; }

  /* Animations — inline content of presentation-skill/animations.css */
  [inline animations.css]

  /* Player — inline content of presentation-skill/player.css */
  [inline player.css]

  /* Base slide */
  .slide { width: 1920px; height: 1080px; background: #FFFFFF; padding: 72px 80px; display: flex; flex-direction: column; overflow: hidden; }

  /* Per-layout CSS — copy directly from each template */
  [layout-specific CSS]
</style>
</head>
<body>

<div class="player-stage">
  <div class="player-scaler">
    <!-- slide sections -->
    [<section class="slide" data-layout="..."> ... </section>]
  </div>
</div>

<div class="player-counter"></div>

<script>
  /* Player — inline content of presentation-skill/player.js */
  [inline player.js]
</script>

</body>
</html>
```

**Assembly rules:**

- Merge CSS from all templates into one `<style>` block — define `.slide` only once (base), add per-layout styles via `[data-layout="..."]` selectors or unique classes
- Merge `:root` variables — define them once at the top
- Copy chart scripts (donut/pie) directly from the template as inline `<script>` inside the `<section>`
- Each slide resets animations on arrival — handled automatically by player.js
- Images: if the user provided a filename, use `../images/[filename]` as the `src`. If not, leave a placeholder `<div class="photo-placeholder"></div>`.

### 3e. Save the output

Save as `presentation-skill/output/[slug].html` where slug = presentation title converted to lowercase, diacritics removed, spaces → hyphens (e.g. "Q4 Review 2025" → `q4-review-2025.html`).

Tell the user the file path and how to open it (`localhost:4200/output/[file].html` if the server is running, otherwise open directly in the browser).

---

## Conventions and constraints

- Never use a layout for content it wasn't designed for (see SPEC).
- If the content doesn't fit any layout, say so and suggest an alternative.
- Recommended presentation structure: intro → content (2–8 slides) → closing. Use brand claim and section divider slides for pacing, not by default.
- If the user provides more content than fits on one slide, split it across multiple slides of the same layout.
- Always respect the character limits in the SPEC — trim rather than overflow.
