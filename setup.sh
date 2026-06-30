#!/bin/bash
# Alma Presentation Skill — Mac/Linux setup
# Run once after cloning. After that, /present works in any Claude Code conversation.

REPO_PATH="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.claude/commands"
SOURCE_FILE="$REPO_PATH/.claude/commands/present.md"
TARGET_FILE="$TARGET_DIR/present.md"

if [ ! -f "$SOURCE_FILE" ]; then
  echo "Error: present.md not found. Run this script from the repo root."
  exit 1
fi

mkdir -p "$TARGET_DIR"

# Replace relative paths with absolute paths pointing to this repo
sed \
  -e "s|Read \`SPEC\.md\`|Read \`$REPO_PATH/SPEC.md\`|g" \
  -e "s|from \`templates/\`|from \`$REPO_PATH/templates/\`|g" \
  -e "s|Save as \`output/|Save as \`$REPO_PATH/output/|g" \
  -e "s|the \`images/\` folder|the \`$REPO_PATH/images/\` folder|g" \
  -e "s|\.\./images/|$REPO_PATH/images/|g" \
  "$SOURCE_FILE" > "$TARGET_FILE"

echo ""
echo "Done! /present is now available in any Claude Code conversation."
echo ""
echo "To browse slide templates, run:"
echo "  npx serve -p 4200 \"$REPO_PATH\""
echo "Then open: http://localhost:4200/showcase.html"
echo ""
