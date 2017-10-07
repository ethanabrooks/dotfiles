#!/bin/bash -ue

# enable terminal colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
cyan=6
green=2
normal=9

function print() {
  tput setaf $cyan
  printf "\n$1\n"
  tput setaf $normal
}

# print "Do you have root privileges? [y|n]"
# read privileged
privileged='y'

if [[ $privileged == 'y' ]]; then
 # /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || :
#	brew update
  brew install \
    curl \
    zsh \
    tree \
    the_silver_searcher \
    macvim \
    neovim \
    || :
  sudo pip install --upgrade pip virtualenvwrapper
  mkdir -p "$HOME/virtualenvs"

  print 'Cloning zsh-syntax-highlighting...'
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/zsh-syntax-highlighting" || :
  zsh_dir=$(brew info zsh | ag zsh/ | tail -1 | cut -d' ' -f1)
  zsh_path=$zsh_dir/bin/zsh
  sudo dscl . -create /Users/$USER UserShell $zsh_path
  sudo easy_install pip
fi

print 'Linking local dotfiles'
bash "$HOME/dotfiles/link-config.sh"

print 'Downloading vim-plug...'
curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# hack to fix file encoding in vimrc
#print 'Setting encodings to utf-8...'
#sed -i '1iscriptencoding utf-8\nset encoding=utf-8' "$HOME/.vimrc"

print 'Installing vim plugins...'
vim -c PlugInstall -c qall

GREEN=2
tput setaf $green
printf "\nAll done! Congratulations, your system is all setup.\n"
zsh

