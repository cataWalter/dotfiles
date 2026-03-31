# ==========================================
# Sync Dotfiles - Windows PowerShell Script
# ==========================================
# This script copies the current configuration from the user's machine
# back into the dotfiles repository for version control.
# ==========================================

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepoRoot = Split-Path -Parent $ScriptDir
$HomeDir = $env:USERPROFILE

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Syncing Windows Dotfiles" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Function to copy config files from home directory to repo
function Sync-Config {
    param(
        [string]$Source,
        [string]$Destination,
        [string]$Description
    )
    
    if (Test-Path $Source) {
        $DestDir = Split-Path -Parent $Destination
        if (-not (Test-Path $DestDir)) {
            New-Item -ItemType Directory -Path $DestDir -Force | Out-Null
            Write-Host "  Created directory: $DestDir" -ForegroundColor Yellow
        }
        
        Copy-Item -Path $Source -Destination $Destination -Force
        Write-Host "  Synced: $Description" -ForegroundColor Green
    } else {
        Write-Host "  Skipped (not found): $Source" -ForegroundColor Gray
    }
}

# Sync root-level configs
Write-Host "Syncing shared configs..." -ForegroundColor Cyan
Sync-Config -Source "$HomeDir\.gitconfig" -Destination "$RepoRoot\.gitconfig" -Description ".gitconfig"

# Sync PowerShell profile
Write-Host ""
Write-Host "Syncing PowerShell profile..." -ForegroundColor Cyan
$ProfilePath = "$HomeDir\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
Sync-Config -Source $ProfilePath -Destination "$ScriptDir\Microsoft.PowerShell_profile.ps1" -Description "PowerShell Profile"

# Sync .config files
Write-Host ""
Write-Host "Syncing .config files..." -ForegroundColor Cyan

# VS Code settings
Sync-Config -Source "$HomeDir\AppData\Roaming\Code\User\settings.json" -Destination "$ScriptDir\.config\vscode\settings.json" -Description "VS Code settings"
Sync-Config -Source "$HomeDir\AppData\Roaming\Code\User\keybindings.json" -Destination "$ScriptDir\.config\vscode\keybindings.json" -Description "VS Code keybindings"

# GitHub CLI config
Sync-Config -Source "$HomeDir\.config\gh\config.yml" -Destination "$ScriptDir\.config\gh\config.yml" -Description "GitHub CLI config"

# Windows Terminal settings
$WTSettingsPath = "$HomeDir\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
Sync-Config -Source $WTSettingsPath -Destination "$ScriptDir\.config\WindowsTerminal\settings.json" -Description "Windows Terminal settings"

# Generate installed packages list
Write-Host ""
Write-Host "Generating installed packages list..." -ForegroundColor Cyan
if (Get-Command scoop -ErrorAction SilentlyContinue) {
    scoop list | Out-File -FilePath "$ScriptDir\installed-packages.txt" -Encoding utf8
    Write-Host "  Generated: installed-packages.txt" -ForegroundColor Green
} else {
    Write-Host "  Skipped: Scoop not installed" -ForegroundColor Gray
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Dotfiles synced successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Remember to commit and push your changes:" -ForegroundColor Yellow
Write-Host "  git add windows/" -ForegroundColor Yellow
Write-Host "  git commit -m 'sync: update windows dotfiles'" -ForegroundColor Yellow
Write-Host "  git push" -ForegroundColor Yellow
Write-Host ""
