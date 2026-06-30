# Alma Presentation Skill

Generate branded HTML presentations in the Alma Career design system — just describe your content and Claude does the rest.

---

## Requirements

- [Claude Code](https://claude.ai/code) — desktop app or CLI

---

## Installation

**Option A — Git (recommended)**

```
git clone https://github.com/kendyone/Alma-Presentation-Templates.git
```

**Option B — Download ZIP**

Click the green **Code** button on GitHub → **Download ZIP** → unzip the folder anywhere on your computer.

Then open the folder in Claude Code:
- Desktop app: **File → Open Folder** → select the cloned/unzipped folder
- CLI: `cd Alma-Presentation-Templates && claude`

The `/present` command is available immediately after opening.

---

## Usage

Type `/present` in Claude Code to start. Claude will guide you through a short onboarding:

1. **Title** — what the presentation will be called
2. **Topic** — what it's about (the more context, the better)
3. **Presenters** — names and job titles
4. **Images** — whether you'll include photos or logos

After onboarding, Claude proposes a slide structure for your approval, then generates a single self-contained HTML file in the `output/` folder.

---

## Browsing layouts

To browse all 29 available slide templates, start a local preview server in your terminal:

```
npx serve -p 4200 .
```

Then open **http://localhost:4200/showcase.html** in your browser.

> Don't have `npx`? Install [Node.js](https://nodejs.org) first (free, one-time setup).

The showcase shows live animated previews of every layout. Use the filter tabs to browse by category, and click the copy button on any card to copy a ready-to-paste prompt like `Use layout 11. Intro — Multi-Speaker`.

---

## Adding images

If your presentation includes speaker photos, logos or other images:

1. Drop the files into the `images/` folder
2. Tell Claude the filenames (e.g. `jan-novak.jpg`)

Claude will reference them automatically in the generated HTML. Supported formats: JPG, PNG, WebP.

---

## Output

Generated presentations are saved to `output/` as self-contained HTML files. Open them directly in any browser, or via the preview server at `http://localhost:4200/output/[filename].html`.

Navigate slides with **arrow keys** or **space**.

---

## Requesting a new layout

If you need a slide type that doesn't exist yet, click **Ask for a new template** in the showcase header — or contact the author directly.

---

## Author

Created by **Jiří Bárta**

- Slack: [almamedia.slack.com/team/U05064Y137X](https://almamedia.slack.com/team/U05064Y137X)
- Email: [jiri.barta@almamedia.com](mailto:jiri.barta@almamedia.com)
