# Alma Presentation Skill — Windows setup
# Run once after cloning. After that, /present works in any Claude Code conversation.

$RepoPath = $PSScriptRoot
$TargetDir = "$env:USERPROFILE\.claude\commands"
$SourceFile = "$RepoPath\.claude\commands\present.md"
$TargetFile = "$TargetDir\present.md"

if (-not (Test-Path $SourceFile)) {
    Write-Host "Error: present.md not found. Make sure you run this script from the repo root." -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Force $TargetDir | Out-Null
}

Copy-Item $SourceFile $TargetFile -Force

Write-Host ""
Write-Host "Done! /present is now available in any Claude Code conversation." -ForegroundColor Green
Write-Host ""
Write-Host "When you run /present, Claude will ask for the folder path automatically." -ForegroundColor Cyan
Write-Host "Your folder is at: $RepoPath"
Write-Host ""
