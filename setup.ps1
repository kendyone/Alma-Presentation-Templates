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

# Replace relative paths with absolute paths pointing to this repo
$content = Get-Content $SourceFile -Raw -Encoding UTF8
$RepoPathForward = $RepoPath.Replace('\', '/')
$content = $content -replace 'Read `SPEC\.md`', "Read ``$RepoPathForward/SPEC.md``"
$content = $content -replace 'from `templates/`', "from ``$RepoPathForward/templates/``"
$content = $content -replace 'Save as `output/', "Save as ``$RepoPathForward/output/"
$content = $content -replace 'the `images/` folder', "the ``$RepoPathForward/images/`` folder"
$content = $content -replace '`localhost:4200/showcase\.html`', "``localhost:4200/showcase.html`` (run: npx serve -p 4200 \`"$RepoPathForward\`")"
$content = $content -replace '\.\./images/', "$RepoPathForward/images/"

$content | Out-File -FilePath $TargetFile -Encoding UTF8

Write-Host ""
Write-Host "Done! /present is now available in any Claude Code conversation." -ForegroundColor Green
Write-Host ""
Write-Host "To browse slide templates, run this in your terminal:"
Write-Host "  npx serve -p 4200 `"$RepoPath`"" -ForegroundColor Cyan
Write-Host "Then open: http://localhost:4200/showcase.html"
Write-Host ""
