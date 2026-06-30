# Alma Presentation Skill

Generate branded HTML presentations in the Alma Career design system — just describe your content and Claude does the rest.

---

## Requirements

- [Claude Code](https://claude.ai/code) — desktop app or CLI
- [Git](https://git-scm.com/downloads) — to download the files

---

## Installation

### Step 1 — Download the files

**On Windows:** Open PowerShell (press `Win + R`, type `powershell`, press Enter) and paste:

```
git clone https://github.com/kendyone/Alma-Presentation-Templates.git
```

**On Mac:** Open Terminal (press `Cmd + Space`, type `terminal`, press Enter) and paste:

```
git clone https://github.com/kendyone/Alma-Presentation-Templates.git
```

This creates a folder called `Alma-Presentation-Templates` wherever your terminal is open (usually your home folder).

### Step 2 — Run the setup script

**On Windows** (PowerShell):

```
cd Alma-Presentation-Templates
.\setup.ps1
```

**On Mac** (Terminal):

```
cd Alma-Presentation-Templates
bash setup.sh
```

You should see: `Done! /present is now available in any Claude Code conversation.`

### Step 3 — Use it

Open Claude Code, start a new conversation, and type `/present`.

Claude will ask you a few questions and generate your presentation.

---

## Usage

Type `/present` in Claude Code to start. Claude will guide you through a short onboarding:

1. **Folder path** — where you saved the Alma Presentation Templates folder
2. **Title** — what the presentation will be called
3. **Topic** — what it's about (the more context, the better)
4. **Presenters** — names and job titles
5. **Images** — whether you'll include photos or logos

After onboarding, Claude proposes a slide structure for your approval, then generates a single self-contained HTML file. It will tell you exactly where to find it and how to open it.

Navigate slides with **arrow keys** or **space**.

---

## Browsing layouts

Open the `showcase.html` file from your `Alma-Presentation-Templates` folder directly in your browser. It shows live animated previews of every layout.

---

## Adding images

If your presentation includes speaker photos, logos or other images:

1. Drop the files into the `images/` folder inside `Alma-Presentation-Templates`
2. Tell Claude the filenames (e.g. `jan-novak.jpg`)

Claude will reference them automatically. Supported formats: JPG, PNG, WebP.

---

## Requesting a new layout

If you need a slide type that doesn't exist yet, click **Ask for a new template** in the showcase header — or contact the author directly.

---

## Author

Created by **Jiří Bárta**

- Slack: [almamedia.slack.com/team/U05064Y137X](https://almamedia.slack.com/team/U05064Y137X)
- Email: [jiri.barta@almamedia.com](mailto:jiri.barta@almamedia.com)
