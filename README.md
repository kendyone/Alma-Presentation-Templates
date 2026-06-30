# Alma Presentation Skill

Generate branded HTML presentations in the Alma Career design system — just describe your content and Claude does the rest.

---

## Requirements

- [Claude Code](https://claude.ai/code) (desktop app or CLI)

---

## Installation

1. Clone or download this repository
2. Open the root folder in Claude Code

That's it. The `/present` command is available immediately.

---

## Usage

Type `/present` in Claude Code to start. Claude will guide you through a short onboarding:

1. **Title** — what the presentation will be called
2. **Topic** — what it's about (the more context, the better)
3. **Presenters** — names and job titles
4. **Images** — whether you'll include photos or logos

After onboarding, Claude proposes a slide structure for your approval, then generates a single self-contained HTML file.

---

## Browsing layouts

Start the preview server to browse all 28 available slide templates:

```
npx serve -p 4200 presentation-skill
```

Then open **http://localhost:4200/showcase.html** in your browser.

The showcase shows live animated previews of every layout. Use the filter tabs to browse by category, and click the copy button on any card to copy a ready-to-paste prompt like `Use layout 11. Intro — Multi-Speaker`.

---

## Adding images

If your presentation includes speaker photos, logos or other images:

1. Drop the files into the `presentation-skill/images/` folder
2. Tell Claude the filenames (e.g. `jan-novak.jpg`)

Claude will reference them automatically in the generated HTML. Supported formats: JPG, PNG, WebP.

---

## Output

Generated presentations are saved to `presentation-skill/output/` as self-contained HTML files. Open them directly in any browser, or serve them via the preview server at `http://localhost:4200/output/[filename].html`.

Navigate slides with **arrow keys** or **space**.

---

## Requesting a new layout

If you need a slide type that doesn't exist yet, click **Ask for a new template** in the showcase header.
