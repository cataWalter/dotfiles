#!/bin/zsh

set -euo pipefail

repo_root=${0:A:h:h}
home_dir=${HOME}

copy_file() {
  local source_path=$1
  local target_path=$2

  if [[ -f "$source_path" ]]; then
    mkdir -p "${target_path:h}"
    cp "$source_path" "$target_path"
  fi
}

copy_dir_contents() {
  local source_dir=$1
  local target_dir=$2

  if [[ -d "$source_dir" ]]; then
    mkdir -p "$target_dir"
    rsync -a --delete "$source_dir/" "$target_dir/"
  fi
}

sanitize_gitconfig() {
  local target_path=$1

  if [[ -f "$target_path" ]]; then
    perl -0pi -e 's@\Q$ENV{HOME}\E/@~/@g' "$target_path"
  fi
}

sanitize_vscode_settings() {
  local target_path=$1

  if [[ -f "$target_path" ]]; then
    perl -0pi -e 's@\n    "sonarlint\.connectedMode\.connections\.sonarqube": \[\n        \{\n            "serverUrl": ".*?",\n            "connectionId": ".*?"\n        \}\n    \],@@s' "$target_path"
    perl -0pi -e 's@\n    "kilo-code\.allowedCommands": \[.*?\],@@s' "$target_path"
    perl -0pi -e 's@\n    "kilo-code\.deniedCommands": \[\],@@s' "$target_path"
  fi
}

export_plist() {
  local plist_name=$1
  local source_path="$home_dir/Library/Preferences/$plist_name"
  local target_path="$repo_root/.config/macos/preferences/$plist_name"

  if [[ -f "$source_path" ]]; then
    mkdir -p "${target_path:h}"
    plutil -convert xml1 -o "$target_path" "$source_path"

    case "$plist_name" in
      com.0804Team.KeyClu.plist)
        perl -0pi -e 's@\n\t<key>SULastCheckTime</key>\n\t<date>.*?</date>@@s' "$target_path"
        ;;
      dev.kiro.desktop.plist)
        perl -0pi -e 's@\n\t<key>SKPurchaseIntentUpdatesLastChecked</key>\n\t<real>.*?</real>@@s' "$target_path"
        ;;
    esac
  fi
}

rm -rf \
  "$repo_root/.config/bruno" \
  "$repo_root/.config/gh" \
  "$repo_root/.config/kube" \
  "$repo_root/.config/maven" \
  "$repo_root/.config/raycast" \
  "$repo_root/.config/vscode" \
  "$repo_root/.config/macos/preferences"

copy_file "$home_dir/.gitconfig" "$repo_root/.gitconfig"
sanitize_gitconfig "$repo_root/.gitconfig"
copy_file "$home_dir/.zshrc" "$repo_root/.zshrc"
copy_file "$home_dir/.aerospace.toml" "$repo_root/.config/aerospace/.aerospace.toml"
copy_file "$home_dir/.config/ghostty/config" "$repo_root/.config/ghostty/config"
copy_file "$home_dir/.config/starship.toml" "$repo_root/.config/starship.toml"
copy_file "$home_dir/.config/karabiner/karabiner.json" "$repo_root/.config/karabiner/karabiner.json"
copy_file "$home_dir/.config/borders/bordersrc" "$repo_root/.config/borders/bordersrc"
copy_file "$home_dir/.config/gh/config.yml" "$repo_root/.config/gh/config.yml"

copy_file "$home_dir/Library/Application Support/Code/User/settings.json" "$repo_root/.config/vscode/settings.json"
sanitize_vscode_settings "$repo_root/.config/vscode/settings.json"
copy_file "$home_dir/Library/Application Support/Code/User/keybindings.json" "$repo_root/.config/vscode/keybindings.json"
copy_dir_contents "$home_dir/Library/Application Support/Code/User/snippets" "$repo_root/.config/vscode/snippets"

for plist_name in \
  com.0804Team.KeyClu.plist \
  com.intelliscapesolutions.caffeine.plist \
  com.wulkano.kap.plist \
  dev.kiro.desktop.plist \
  wang.jianing.app.OpenInTerminal-Lite.plist; do
  export_plist "$plist_name"
done

find "$repo_root/.config" -type f | sort