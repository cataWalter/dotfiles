#!/bin/bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Generating system information..."

# GNOME Extensions
echo "Generating GNOME extensions list..."
gnome-extensions list 2>/dev/null > "$repo_root/gnome-extensions.txt" || echo "Failed to get GNOME extensions"

# Installed packages
echo "Generating installed packages list..."
if command -v rpm &>/dev/null; then
    rpm -qa --qf '%{NAME}\n' 2>/dev/null | sort | uniq > "$repo_root/installed-packages.txt"
    echo "Found $(wc -l < "$repo_root/installed-packages.txt") installed packages"
elif command -v dpkg &>/dev/null; then
    dpkg --get-selections | grep -v deinstall | awk '{print $1}' | sort > "$repo_root/installed-packages.txt"
    echo "Found $(wc -l < "$repo_root/installed-packages.txt") installed packages"
else
    echo "No supported package manager found"
fi

echo ""
echo "System information generated at $repo_root"
