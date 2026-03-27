# Dotfiles

This repository stores a curated subset of machine settings and application configuration from macOS.

## What is synced

- Shell and CLI config:
  - `.gitconfig`
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

These exclusions are enforced in [.gitignore](.gitignore).

## Refresh from this machine

Run the sync script to copy the curated files from your home directory into this repository:

```sh
./scripts/sync-dotfiles.sh
```

## Apply onto a machine

Run the apply script to copy the curated files from this repository back into your home directory:

```sh
./scripts/apply-dotfiles.sh
```

The apply script creates target directories as needed and copies the saved macOS preference plists back to `~/Library/Preferences`.

## Notes

- Preference plist changes may require restarting the target app before they take effect.
- Some applications also keep state outside the saved files in this repo.
- Review diffs before committing because app configs can still contain machine-specific values.