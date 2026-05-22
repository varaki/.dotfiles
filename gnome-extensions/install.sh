#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Usage: $(basename "$0") [OPTION]"
  echo ""
  echo "Options:"
  echo "  (none)      Install extensions (uninstalls, cleans, reinstalls, restores config)"
  echo "  --remove    Remove selected extensions and clean up their data"
  echo "  -h, --help  Show this help message"
  exit 0
fi

ALL_EXTENSIONS=(
  "clipboard-indicator@tudmotu.com"
  "dash-to-dock@micxgx.gmail.com"
  "Vitals@CoreCoding.com"
)

cleanup_extension() {
  local ext="$1"
  local name="$(echo "${ext%%@*}" | tr '[:upper:]' '[:lower:]')"
  rm -rf ~/.cache/"$ext"
  while [ -n "$(dconf dump /org/gnome/shell/extensions/$name/)" ]; do
    dconf reset -f "/org/gnome/shell/extensions/$name/"
    sleep 1
  done
}

if [[ "$1" == "--remove" ]]; then
  echo "Select extensions to remove:"
  SELECTED=()
  for ext in "${ALL_EXTENSIONS[@]}"; do
    if gnome-extensions list 2>/dev/null | grep -q "^${ext}$"; then
      read -p "  Remove $ext? [Y/n] " answer
      if [[ "${answer,,}" != "n" ]]; then
        SELECTED+=("$ext")
      fi
    fi
  done

  if [ ${#SELECTED[@]} -eq 0 ]; then
    echo "No extensions selected. Exiting."
    exit 0
  fi

  for ext in "${SELECTED[@]}"; do
    echo "Removing $ext..."
    gnome-extensions disable "$ext" 2>/dev/null || true
    gnome-extensions uninstall "$ext" 2>/dev/null || true
  done

  for ext in "${SELECTED[@]}"; do
    echo "Cleaning up $ext..."
    cleanup_extension "$ext"
  done

  echo "Done!"
  exit 0
fi

echo "Select extensions to install:"
EXTENSIONS=()
for ext in "${ALL_EXTENSIONS[@]}"; do
  read -p "  Install $ext? [Y/n] " answer
  if [[ "${answer,,}" != "n" ]]; then
    EXTENSIONS+=("$ext")
  fi
done

if [ ${#EXTENSIONS[@]} -eq 0 ]; then
  echo "No extensions selected. Exiting."
  exit 0
fi

# Uninstall selected extensions
for ext in "${EXTENSIONS[@]}"; do
  echo "Removing $ext..."
  gnome-extensions disable "$ext" 2>/dev/null || true
  gnome-extensions uninstall "$ext" 2>/dev/null || true
done

# Clean extension caches and dconf settings
for ext in "${EXTENSIONS[@]}"; do
  echo "Cleaning up $ext..."
  cleanup_extension "$ext"
done

# Install extensions via GNOME Shell D-Bus (will prompt for permission in GUI)
for ext in "${EXTENSIONS[@]}"; do
  echo "Installing $ext... (approve the prompt in GUI)"
  gdbus call --session \
    --dest org.gnome.Shell.Extensions \
    --object-path /org/gnome/Shell/Extensions \
    --method org.gnome.Shell.Extensions.InstallRemoteExtension \
    "$ext" >/dev/null 2>&1 || true
  # Wait until the extension is installed
  while ! gnome-extensions list 2>/dev/null | grep -q "^${ext}$"; do
    sleep 1
  done
  echo "$ext installed."
done

# Enable extensions
for ext in "${EXTENSIONS[@]}"; do
  gnome-extensions enable "$ext"
done

# Restore settings
for ext in "${EXTENSIONS[@]}"; do
  name="$(echo "${ext%%@*}" | tr '[:upper:]' '[:lower:]')"
  dconf_file="$SCRIPT_DIR/configs/$name.dconf"
  if [ -f "$dconf_file" ]; then
    echo "Restoring settings for $name..."
    dconf load "/org/gnome/shell/extensions/$name/" < "$dconf_file"
  fi
done

echo "Done! All extensions installed and configured."
