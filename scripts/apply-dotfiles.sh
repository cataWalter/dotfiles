#!/bin/zsh

set -euo pipefail

repo_root=${0:A:h:h}
home_dir=${HOME}

install_file() {
  local source_path=$1
  local target_path=$2

  if [[ -f "$source_path" ]]; then
    mkdir -p "${target_path:h}"
    cp "$source_path" "$target_path"
  fi
}

install_dir_contents() {
  local source_dir=$1
  local target_dir=$2

  if [[ -d "$source_dir" ]]; then
    mkdir -p "$target_dir"
    rsync -a --delete "$source_dir/" "$target_dir/"
  fi
}

install_file "$repo_root/.gitconfig" "$home_dir/.gitconfig"
install_file "$repo_root/.zshrc" "$home_dir/.zshrc"
install_file "$repo_root/.config/aerospace/.aerospace.toml" "$home_dir/.aerospace.toml"
install_file "$repo_root/.config/ghostty/config" "$home_dir/.config/ghostty/config"
install_file "$repo_root/.config/starship.toml" "$home_dir/.config/starship.toml"
install_file "$repo_root/.config/karabiner/karabiner.json" "$home_dir/.config/karabiner/karabiner.json"
install_file "$repo_root/.config/borders/bordersrc" "$home_dir/.config/borders/bordersrc"
install_file "$repo_root/.config/gh/config.yml" "$home_dir/.config/gh/config.yml"

install_file "$repo_root/.config/vscode/settings.json" "$home_dir/Library/Application Support/Code/User/settings.json"
install_file "$repo_root/.config/vscode/keybindings.json" "$home_dir/Library/Application Support/Code/User/keybindings.json"
install_dir_contents "$repo_root/.config/vscode/snippets" "$home_dir/Library/Application Support/Code/User/snippets"

if [[ -d "$repo_root/.config/macos/preferences" ]]; then
  mkdir -p "$home_dir/Library/Preferences"
  rsync -a "$repo_root/.config/macos/preferences/" "$home_dir/Library/Preferences/"
fi

echo "Applied curated dotfiles from $repo_root to $home_dir"