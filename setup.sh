#!/bin/bash
# Resolve the repo from the script's own location (physical path, no symlinks)
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)

# Replace ~/target with a symlink to src. Skips targets whose parent dir is
# itself a symlink into the repo: rm there would delete the repo's own file.
link_file() {
  local src=$1 target=$2
  local parent
  parent=$(cd "$(dirname "$target")" && pwd -P)
  case "$parent/" in
    "$DOTFILES_DIR"/*)
      echo "Skipping $target: its directory resolves into the dotfiles repo ($parent)"
      return
      ;;
  esac
  if [ -f "$target" ] || [ -L "$target" ]; then
    echo "Removing existing file/symlink: $target"
    rm -f "$target"
  fi
  echo "Creating symlink: $target --> $src"
  ln -s "$src" "$target"
}

declare -a FILES_TO_SYMLINK=(
  '.bashrc'
  '.zshrc'
  '.bash_profile'
  '.editorconfig'
  '.promptlinerc'
  '.tmux.conf'
  '.config/nvim/init.vim'
  ".config/nvim/init.lua"
  ".config/nvim/lua/config/lazy.lua"
  ".config/kitty/kitty.conf"
  '.p10k.zsh'
  '.gitconfig'
)

declare -a DIRECTORIES_TO_CREATE=(
  '.config/nvim/lua/config'
  '.config/nvim/lua/plugins'  # Ensure the plugins directory exists
  '.config/kitty'
)

# Create necessary directories
for dir in "${DIRECTORIES_TO_CREATE[@]}"; do
  echo "Creating prerequisite directory: ~/$dir"
  mkdir -p ~/$dir
done

# Symlink individual files
for file in "${FILES_TO_SYMLINK[@]}"; do
  link_file "$DOTFILES_DIR/$file" ~/"$file"
done

# Symlink all Lua plugin files dynamically
PLUGIN_DIR=".config/nvim/lua/plugins"
mkdir -p ~/$PLUGIN_DIR  # Ensure the directory exists

for plugin_file in $DOTFILES_DIR/$PLUGIN_DIR/*.lua; do
  link_file "$plugin_file" ~/"$PLUGIN_DIR/$(basename "$plugin_file")"
done

echo "Symlink process completed!"
