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
cp "$SOURCE_FILE" "$TARGET_FILE"

echo ""
echo ""
echo "Done! /present is now available in any Claude Code conversation."
echo ""
echo "IMPORTANT — copy this path, Claude will ask for it when you run /present:"
echo "$REPO_PATH"
echo ""
