#!/bin/bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
home_dir="${HOME}"

install_file() {
  local source_path=$1
  local target_path=$2

  if [[ -f "$source_path" ]]; then
    mkdir -p "$(dirname "$target_path")"
    cp "$source_path" "$target_path"
    echo "Installed: $target_path"
  fi
}

install_dir_contents() {
  local source_dir=$1
  local target_dir=$2

  if [[ -d "$source_dir" ]]; then
    mkdir -p "$target_dir"
    rsync -a --delete "$source_dir/" "$target_dir/"
    echo "Installed: $target_dir"
  fi
}

# Root-level dotfiles
install_file "$repo_root/../.gitconfig" "$home_dir/.gitconfig"
install_file "$repo_root/../.zshrc" "$home_dir/.zshrc"
install_file "$repo_root/../.bashrc" "$home_dir/.bashrc"
install_file "$repo_root/../.bash_profile" "$home_dir/.bash_profile"
install_file "$repo_root/../.bash_logout" "$home_dir/.bash_logout"

# Config files
install_file "$repo_root/.config/starship.toml" "$home_dir/.config/starship.toml"
install_file "$repo_root/.config/gh/config.yml" "$home_dir/.config/gh/config.yml"
install_file "$repo_root/.config/ghostty/config" "$home_dir/.config/ghostty/config"

# VS Code
install_file "$repo_root/.config/vscode/settings.json" "$home_dir/.config/Code/User/settings.json"
install_file "$repo_root/.config/vscode/keybindings.json" "$home_dir/.config/Code/User/keybindings.json"
install_dir_contents "$repo_root/.config/vscode/snippets" "$home_dir/.config/Code/User/snippets"

# GTK
install_file "$repo_root/.config/gtk-3.0/gtk.css" "$home_dir/.config/gtk-3.0/gtk.css"
install_file "$repo_root/.config/gtk-3.0/bookmarks" "$home_dir/.config/gtk-3.0/bookmarks"
install_file "$repo_root/.config/gtk-4.0/gtk.css" "$home_dir/.config/gtk-4.0/gtk.css"

# XDG user dirs
install_file "$repo_root/.config/user-dirs.dirs" "$home_dir/.config/user-dirs.dirs"
install_file "$repo_root/.config/user-dirs.locale" "$home_dir/.config/user-dirs.locale"

# MIME applications
install_file "$repo_root/.config/mimeapps.list" "$home_dir/.config/mimeapps.list"

# Dconf (GNOME settings)
install_file "$repo_root/.config/dconf/user" "$home_dir/.config/dconf/user"

# Pop-shell
install_file "$repo_root/.config/pop-shell/config.json" "$home_dir/.config/pop-shell/config.json"

# Xournal++
install_file "$repo_root/.config/xournalpp/settings.xml" "$home_dir/.config/xournalpp/settings.xml"

# Flatpak overrides
install_file "$repo_root/.local/share/flatpak/overrides/global" "$home_dir/.local/share/flatpak/overrides/global"

# GNOME shell extensions metadata
for ext in blur-my-shell@aunetx burn-my-windows@schneegans.github.com compiz-windows-effect@hermes83.github.com dash-to-dock@micxgx.gmail.com drive-menu@gnome-shell-extensions.gcampax.github.com just-perfection-desktop@just-perfection mediacontrols@cliffniff.github.com openbar@neuromorph rounded-window-corners@fxgn space-bar@luchrioh Vitals@CoreCoding.com; do
  install_file "$repo_root/.local/share/gnome-shell/extensions/$ext/metadata.json" "$home_dir/.local/share/gnome-shell/extensions/$ext/metadata.json"
done

echo ""
echo "Applied curated dotfiles from $repo_root to $home_dir"
