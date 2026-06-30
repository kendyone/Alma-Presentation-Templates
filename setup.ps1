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

$RepoPathForward = $RepoPath.Replace('\', '/')
$content = Get-Content $SourceFile -Raw -Encoding UTF8
$content = $content -replace '\[FOLDER\]', $RepoPathForward
$content | Out-File -FilePath $TargetFile -Encoding UTF8

Write-Host ""
Write-Host "Done! /present is now available in any Claude Code conversation." -ForegroundColor Green
Write-Host ""
