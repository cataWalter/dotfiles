# ==========================================
# Apply Dotfiles - Windows PowerShell Script
# ==========================================
# This script applies the Windows dotfiles to the user's home directory.
# Run this script with PowerShell (preferably as Administrator for some operations).
# ==========================================

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepoRoot = Split-Path -Parent $ScriptDir
$HomeDir = $env:USERPROFILE

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Applying Windows Dotfiles" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Function to copy config files
function Copy-Config {
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
        Write-Host "  Applied: $Description" -ForegroundColor Green
    } else {
        Write-Host "  Skipped (not found): $Source" -ForegroundColor Gray
    }
}

# Apply root-level configs
Write-Host "Applying shared configs..." -ForegroundColor Cyan
Copy-Config -Source "$RepoRoot\.gitconfig" -Destination "$HomeDir\.gitconfig" -Description ".gitconfig"

# Apply PowerShell profile
Write-Host ""
Write-Host "Applying PowerShell profile..." -ForegroundColor Cyan
$ProfileDir = "$HomeDir\Documents\PowerShell"
$ProfilePath = "$ProfileDir\Microsoft.PowerShell_profile.ps1"
Copy-Config -Source "$ScriptDir\Microsoft.PowerShell_profile.ps1" -Destination $ProfilePath -Description "PowerShell Profile"

# Apply .config files
Write-Host ""
Write-Host "Applying .config files..." -ForegroundColor Cyan

# Starship config (shared)
if (Test-Path "$RepoRoot\macos\.config\starship.toml") {
    Copy-Config -Source "$RepoRoot\macos\.config\starship.toml" -Destination "$HomeDir\.config\starship.toml" -Description "starship.toml"
} elseif (Test-Path "$ScriptDir\.config\starship.toml") {
    Copy-Config -Source "$ScriptDir\.config\starship.toml" -Destination "$HomeDir\.config\starship.toml" -Description "starship.toml"
}

# VS Code settings
Copy-Config -Source "$ScriptDir\.config\vscode\settings.json" -Destination "$HomeDir\.config\vscode\settings.json" -Description "VS Code settings"
Copy-Config -Source "$ScriptDir\.config\vscode\keybindings.json" -Destination "$HomeDir\.config\vscode\keybindings.json" -Description "VS Code keybindings"

# GitHub CLI config
Copy-Config -Source "$ScriptDir\.config\gh\config.yml" -Destination "$HomeDir\.config\gh\config.yml" -Description "GitHub CLI config"

# Windows Terminal settings
Copy-Config -Source "$ScriptDir\.config\WindowsTerminal\settings.json" -Destination "$HomeDir\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Description "Windows Terminal settings"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Dotfiles applied successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Please restart your terminal and applications for changes to take effect." -ForegroundColor Yellow
Write-Host ""
