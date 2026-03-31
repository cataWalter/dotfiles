# ==========================================
# ENVIRONMENT VARIABLES & PATHS
# ==========================================

# Add common paths
$env:PATH = "$env:USERPROFILE\scoop\shims;$env:PATH"
$env:PATH = "$env:USERPROFILE\.local\bin;$env:PATH"

# Python & UV
$env:PYTHONHTTPSVERIFY = "0"
$env:UV_TLS_INSECURE = "true"

# Java & Maven (adjust paths as needed)
# $env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
# $env:MAVEN_HOME = "C:\Program Files\Apache\maven"

# ==========================================
# ALIASES (Functions in PowerShell)
# ==========================================

function python { python3 @args }
function pip { pip3 @args }

# Git aliases
function gitamend {
    git add .
    git commit --amend --no-edit
    git push -f
}

# List directory aliases
function ll { Get-ChildItem -Force -Long }
function la { Get-ChildItem -Force }

# ==========================================
# PLUGINS & PROMPT
# ==========================================

# Initialize Starship prompt
if (Get-Command starship -ErrorAction SilentlyContinue) {
    $env:STARSHIP_CONFIG = "$env:USERPROFILE\.config\starship.toml"
    Invoke-Expression (&starship init powershell)
}

# ==========================================
# SHELL OPTIONS
# ==========================================

# Set execution policy for current session (if needed)
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Enable PSReadLine for better history and editing
if (Get-Module -ListAvailable -Name PSReadLine) {
    Import-Module PSReadLine
    Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
}

# ==========================================
# HELPER FUNCTIONS
# ==========================================

# Quick directory navigation
function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }

# Create directory and enter it
function mkcd {
    param([string]$Path)
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
    Set-Location $Path
}

# Extract archives
function extract {
    param([string]$Path)
    if (Test-Path $Path) {
        switch -Regex ($Path) {
            '\.zip$' { Expand-Archive -Path $Path -DestinationPath (Split-Path $Path -Leaf -Resolve) }
            '\.tar\.gz$' { tar -xzf $Path }
            '\.tar$' { tar -xf $Path }
            default { Write-Host "Unknown archive format" }
        }
    } else {
        Write-Host "File not found: $Path"
    }
}
