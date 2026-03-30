#!/bin/bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
home_dir="${HOME}"

copy_file() {
  local source_path=$1
  local target_path=$2

  if [[ -f "$source_path" ]]; then
    mkdir -p "$(dirname "$target_path")"
    cp "$source_path" "$target_path"
    echo "Synced: $target_path"
  fi
}

copy_dir_contents() {
  local source_dir=$1
  local target_dir=$2

  if [[ -d "$source_dir" ]]; then
    mkdir -p "$target_dir"
    rsync -a --delete "$source_dir/" "$target_dir/"
    echo "Synced: $target_dir"
  fi
}

sanitize_gitconfig() {
  local target_path=$1

  if [[ -f "$target_path" ]]; then
    sed -i "s|$HOME/|~/|g" "$target_path"
  fi
}

# Clean previous sync
rm -rf \
  "$repo_root/.config/gh" \
  "$repo_root/.config/vscode" \
  "$repo_root/.config/gtk-3.0" \
  "$repo_root/.config/gtk-4.0" \
  "$repo_root/.config/dconf" \
  "$repo_root/.config/pop-shell" \
  "$repo_root/.config/xournalpp"

# Root-level dotfiles
copy_file "$home_dir/.gitconfig" "$repo_root/../.gitconfig"
sanitize_gitconfig "$repo_root/../.gitconfig"
copy_file "$home_dir/.zshrc" "$repo_root/../.zshrc"
copy_file "$home_dir/.bashrc" "$repo_root/../.bashrc"
copy_file "$home_dir/.bash_profile" "$repo_root/../.bash_profile"
copy_file "$home_dir/.bash_logout" "$repo_root/../.bash_logout"

# Config files
copy_file "$home_dir/.config/starship.toml" "$repo_root/.config/starship.toml"
copy_file "$home_dir/.config/gh/config.yml" "$repo_root/.config/gh/config.yml"
copy_file "$home_dir/.config/ghostty/config" "$repo_root/.config/ghostty/config"

# VS Code settings
copy_file "$home_dir/.config/Code/User/settings.json" "$repo_root/.config/vscode/settings.json"
copy_file "$home_dir/.config/Code/User/keybindings.json" "$repo_root/.config/vscode/keybindings.json"
copy_dir_contents "$home_dir/.config/Code/User/snippets" "$repo_root/.config/vscode/snippets"

# GTK configs
copy_file "$home_dir/.config/gtk-3.0/gtk.css" "$repo_root/.config/gtk-3.0/gtk.css"
copy_file "$home_dir/.config/gtk-3.0/bookmarks" "$repo_root/.config/gtk-3.0/bookmarks"
copy_file "$home_dir/.config/gtk-4.0/gtk.css" "$repo_root/.config/gtk-4.0/gtk.css"

# XDG user dirs
copy_file "$home_dir/.config/user-dirs.dirs" "$repo_root/.config/user-dirs.dirs"
copy_file "$home_dir/.config/user-dirs.locale" "$repo_root/.config/user-dirs.locale"

# MIME applications
copy_file "$home_dir/.config/mimeapps.list" "$repo_root/.config/mimeapps.list"

# Dconf (GNOME settings)
copy_file "$home_dir/.config/dconf/user" "$repo_root/.config/dconf/user"

# Pop-shell
copy_file "$home_dir/.config/pop-shell/config.json" "$repo_root/.config/pop-shell/config.json"

# Xournal++
copy_file "$home_dir/.config/xournalpp/settings.xml" "$repo_root/.config/xournalpp/settings.xml"

# Flatpak overrides
copy_file "$home_dir/.local/share/flatpak/overrides/global" "$repo_root/.local/share/flatpak/overrides/global"

# GNOME shell extensions metadata
for ext in blur-my-shell@aunetx burn-my-windows@schneegans.github.com compiz-windows-effect@hermes83.github.com dash-to-dock@micxgx.gmail.com drive-menu@gnome-shell-extensions.gcampax.github.com just-perfection-desktop@just-perfection mediacontrols@cliffniff.github.com openbar@neuromorph rounded-window-corners@fxgn space-bar@luchrioh Vitals@CoreCoding.com; do
  copy_file "$home_dir/.local/share/gnome-shell/extensions/$ext/metadata.json" "$repo_root/.local/share/gnome-shell/extensions/$ext/metadata.json"
done

echo ""
echo "=== Config files ==="
find "$repo_root/.config" -type f | sort
echo ""
echo "=== Local files ==="
find "$repo_root/.local" -type f | sort
echo ""
echo "Synced dotfiles from $home_dir to $repo_root"
