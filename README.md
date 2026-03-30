# Dotfiles

This repository stores a curated subset of machine settings and application configuration for both **macOS** and **Linux**.

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
└── linux/              # Linux-specific configs
    ├── .bashrc
    ├── .bash_profile
    ├── .bash_logout
    ├── .config/
    │   ├── dconf/
    │   ├── gh/
    │   ├── ghostty/
    │   ├── gtk-3.0/
    │   ├── gtk-4.0/
    │   ├── mimeapps.list
    │   ├── pop-shell/
    │   ├── starship.toml
    │   ├── user-dirs.dirs
    │   ├── user-dirs.locale
    │   ├── vscode/
    │   └── xournalpp/
    ├── .local/
    │   └── share/
    │       ├── flatpak/overrides/
    │       └── gnome-shell/extensions/
    ├── gnome-extensions.txt    # List of installed GNOME extensions
    ├── installed-packages.txt  # List of all installed RPM packages
    └── scripts/
        ├── apply-dotfiles.sh
        ├── sync-dotfiles.sh
        └── generate-system-info.sh
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

## Apply onto a machine

### macOS
```sh
./macos/scripts/apply-dotfiles.sh
```

### Linux
```sh
./linux/scripts/apply-dotfiles.sh
```

The apply scripts create target directories as needed and copy the saved configs back to your home directory.

## Notes

- Preference plist changes may require restarting the target app before they take effect.
- Some applications also keep state outside the saved files in this repo.
- Review diffs before committing because app configs can still contain machine-specific values.
