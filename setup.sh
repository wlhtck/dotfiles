#!/bin/bash
DOTFILES_DIR=$(pwd)  # Assumes the script runs from the dotfiles repo

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
  if [ -f ~/$file ] || [ -L ~/$file ]; then
    echo "Removing existing file/symlink: ~/$file"
    rm -f ~/$file
  fi
  echo "Creating symlink: ~/$file --> $DOTFILES_DIR/$file" 
  ln -s $DOTFILES_DIR/$file ~/$file
done

# Symlink all Lua plugin files dynamically
PLUGIN_DIR=".config/nvim/lua/plugins"
mkdir -p ~/$PLUGIN_DIR  # Ensure the directory exists

for plugin_file in $DOTFILES_DIR/$PLUGIN_DIR/*.lua; do
  filename=$(basename "$plugin_file")
  
  if [ -f ~/$PLUGIN_DIR/$filename ] || [ -L ~/$PLUGIN_DIR/$filename ]; then
    echo "Removing existing file/symlink: ~/$PLUGIN_DIR/$filename"
    rm -f ~/$PLUGIN_DIR/$filename
  fi

  echo "Creating symlink: ~/$PLUGIN_DIR/$filename --> $plugin_file"
  ln -s "$plugin_file" ~/$PLUGIN_DIR/$filename
done

echo "Symlink process completed!"
