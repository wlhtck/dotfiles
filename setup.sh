declare -a FILES_TO_SYMLINK=(
  '.vimrc'
  '.bashrc'
  '.zshrc'
  '.bash_profile'
  '.editorconfig'
  '.promptlinerc'
  '.tmux.conf'
  '.config/nvim/init.vim'
  ".config/nvim/init.lua"
  ".config/nvim/lua/config/lazy.lua"
  '.config/nvim/coc-settings.json'
  '.config/coc/extensions/package.json'
  '.p10k.zsh'
  '.gitconfig'
)

declare -a DIRECTORIES_TO_CREATE=(
  '.config/nvim/lua/config'
  '.config/coc/extensions'
)

for i in "${DIRECTORIES_TO_CREATE}"; do
  echo "Creating prerequisite directory: ~/$i"
  mkdir -p ~/$i
done

for i in "${FILES_TO_SYMLINK[@]}"; do
  if test -f ~/$i; then
    echo "~/$i exists, removing it first"
    rm ~/$i
  fi

  echo "Creating symlink ~/$i --> $(pwd)/$i"
  ln -s $(pwd)/$i ~/$i
done
