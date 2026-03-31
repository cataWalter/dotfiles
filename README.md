# Dotfiles

This repository stores a curated subset of machine settings and application configuration for **macOS**, **Linux**, and **Windows**.

## Structure

```
.
├── .gitconfig          # Shared git config
├── .zshrc              # Shared zsh config
├── .bashrc             # Linux bash config
├── .bash_profile       # Linux bash profile
├── .bash_logout        # Linux bash logout
├── macos/              # macOS-specific configs
│   ├── Brewfile        # Homebrew packages
│   ├── .config/
│   │   ├── aerospace/
│   │   ├── borders/
│   │   ├── gh/
│   │   ├── ghostty/
│   │   ├── karabiner/
│   │   ├── macos/preferences/
│   │   ├── starship.toml
│   │   └── vscode/
│   └── scripts/
│       ├── apply-dotfiles.sh
│       └── sync-dotfiles.sh
├── linux/              # Linux-specific configs
│   ├── .bashrc
│   ├── .bash_profile
│   ├── .bash_logout
│   ├── .config/
│   │   ├── dconf/
│   │   ├── gh/
│   │   ├── ghostty/
│   │   ├── gtk-3.0/
│   │   ├── gtk-4.0/
│   │   ├── mimeapps.list
│   │   ├── pop-shell/
│   │   ├── starship.toml
│   │   ├── user-dirs.dirs
│   │   ├── user-dirs.locale
│   │   ├── vscode/
│   │   └── xournalpp/
│   ├── .local/
│   │   └── share/
│   │       ├── flatpak/overrides/
│   │       └── gnome-shell/extensions/
│   ├── gnome-extensions.txt    # List of installed GNOME extensions
│   ├── installed-packages.txt  # List of all installed RPM packages
│   └── scripts/
│       ├── apply-dotfiles.sh
│       ├── sync-dotfiles.sh
│       └── generate-system-info.sh
└── windows/            # Windows-specific configs
    ├── Microsoft.PowerShell_profile.ps1  # PowerShell profile
    ├── Scoopfile.json  # Scoop packages
    ├── .config/
    │   ├── gh/
    │   │   └── config.yml
    │   ├── vscode/
    │   │   ├── settings.json
    │   │   └── keybindings.json
    │   └── WindowsTerminal/
    │       └── settings.json
    ├── installed-packages.txt  # List of installed Scoop packages
    └── scripts/
        ├── apply-dotfiles.ps1
        └── sync-dotfiles.ps1
```

## What is synced

### Shared (root level)
- `.gitconfig` - Git configuration

### macOS
- Shell and CLI config:
  - `.zshrc`
  - `.config/starship.toml`
- Window manager and terminal config:
  - `.config/aerospace/.aerospace.toml`
  - `.config/ghostty/config`
  - `.config/borders/bordersrc`
  - `.config/karabiner/karabiner.json`
- App config:
  - `.config/gh/config.yml`
  - `.config/vscode/settings.json`
  - `.config/vscode/keybindings.json`
  - `.config/vscode/snippets/`
- Selected macOS preference exports:
  - small, user-controlled plist files only
- Homebrew packages:
  - `Brewfile`

### Linux
- Shell config:
  - `.bashrc`
  - `.bash_profile`
  - `.bash_logout`
  - `.zshrc` (shared)
- Desktop environment config:
  - `.config/gtk-3.0/gtk.css`
  - `.config/gtk-3.0/bookmarks`
  - `.config/gtk-4.0/gtk.css`
  - `.config/dconf/user` (GNOME settings database)
  - `.config/pop-shell/config.json`
- Terminal and CLI config:
  - `.config/starship.toml`
  - `.config/ghostty/config`
  - `.config/gh/config.yml`
  - `.config/user-dirs.dirs`
  - `.config/user-dirs.locale`
  - `.config/mimeapps.list`
- App config:
  - `.config/vscode/settings.json`
  - `.config/vscode/keybindings.json`
  - `.config/vscode/snippets/`
  - `.config/xournalpp/settings.xml`
- System inventory:
  - `gnome-extensions.txt` - List of installed GNOME shell extensions
  - `installed-packages.txt` - Complete list of installed RPM packages
- User-local configs:
  - `.local/share/flatpak/overrides/global` - Flatpak filesystem permissions
  - `.local/share/gnome-shell/extensions/*/metadata.json` - Extension metadata for all 11 custom extensions

### Windows
- Shell config:
  - `Microsoft.PowerShell_profile.ps1` - PowerShell profile with aliases, functions, and prompt setup
- Package management:
  - `Scoopfile.json` - List of packages managed via Scoop
- Terminal config:
  - `.config/WindowsTerminal/settings.json` - Windows Terminal settings with custom color scheme
- CLI tools config:
  - `.config/starship.toml` (shared with macOS)
  - `.config/gh/config.yml`
- App config:
  - `.config/vscode/settings.json`
  - `.config/vscode/keybindings.json`
- System inventory:
  - `installed-packages.txt` - List of installed Scoop packages

## System Inventory

### GNOME Extensions
The following GNOME extensions are installed on this system:

- **blur-my-shell** - Adds blur effects to panels and overview
- **dash-to-dock** - Transforms the dash into a dock
- **rounded-window-corners** - Adds rounded corners to windows
- **just-perfection** - Customization tool for GNOME
- **Vitals** - System monitor extension
- **burn-my-windows** - Window closing animations
- **compiz-windows-effect** - Compiz-like window effects
- **mediacontrols** - Media player controls
- **drive-menu** - Drive mount menu
- **space-bar** - Workspace indicator
- **openbar** - Status bar customization
- **apps-menu** - Traditional applications menu
- **pop-shell** - Pop OS shell tiling extension

### Installed Packages
A complete list of 2173 installed packages is available in [`linux/installed-packages.txt`](linux/installed-packages.txt:1).

To regenerate the system inventory, run:
```sh
./linux/scripts/generate-system-info.sh
```

## What is intentionally excluded

- Credentials and tokens
- Kubernetes config
- Maven settings with credentials
- GitHub auth hosts
- Bruno workspace and app state
- Spotube cookies and access tokens
- Raycast extension payloads and app caches
- Large machine-specific or low-value application state
- App window positions, recent folders, and telemetry identifiers
- Workspace-specific service endpoints and command allowlists

These exclusions are enforced in [.gitignore](.gitignore).

## Refresh from this machine

### macOS
```sh
./macos/scripts/sync-dotfiles.sh
```

### Linux
```sh
./linux/scripts/sync-dotfiles.sh
```

### Windows
```powershell
.\windows\scripts\sync-dotfiles.ps1
```

## Apply onto a machine

### macOS
```sh
./macos/scripts/apply-dotfiles.sh
```

### Linux
```sh
./linux/scripts/apply-dotfiles.sh
```

### Windows
```powershell
.\windows\scripts\apply-dotfiles.ps1
```

The apply scripts create target directories as needed and copy the saved configs back to your home directory.

## Windows Setup

### Prerequisites

1. **Install Scoop** (Windows package manager):
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
   ```

2. **Install required packages**:
   ```powershell
   scoop install git starship gh fzf ripgrep fd bat eza zoxide
   ```

3. **Install Windows Terminal** from Microsoft Store or via Scoop:
   ```powershell
   scoop install windows-terminal
   ```

### PowerShell Profile Location

The PowerShell profile is installed at:
- **PowerShell 7+**: `$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`
- **Windows PowerShell**: `$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`

## Notes

- Preference plist changes may require restarting the target app before they take effect.
- Some applications also keep state outside the saved files in this repo.
- Review diffs before committing because app configs can still contain machine-specific values.
- On Windows, some configs may need to be copied manually to AppData locations if the scripts don't detect the correct paths.
- Windows Terminal settings.json location may vary depending on installation source (Store vs. Scoop).
- PowerShell execution policy may need to be set to `RemoteSigned` for scripts to run.
