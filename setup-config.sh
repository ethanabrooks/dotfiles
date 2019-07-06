#!/bin/bash -ue

# enable terminal colors
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
  brew install \
    curl \
    zsh \
    tree \
    the_silver_searcher \
    macvim \
    neovim \
    || :
  sudo easy_install pip
  sudo pip install --upgrade pip virtualenvwrapper neovim
  mkdir -p "$HOME/virtualenvs"

  print 'Cloning zsh-syntax-highlighting...'
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/zsh-syntax-highlighting" || :

  zsh_dir=$(brew info zsh | ag zsh/ | tail -1 | cut -d' ' -f1)
  sudo dscl . -create /Users/$USER UserShell $zsh_dir/bin/zsh
fi

print 'Linking local dotfiles'
bash "$HOME/dotfiles/link-config.sh"

print 'Downloading vim-plug...'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

print 'Installing vim plugins...'
nvim +PlugInstall +qall

GREEN=2
tput setaf $green
printf "\nAll done! Congratulations, your system is all setup.\n"
zsh

cd ~/dotfiles
git submodule init
git submodule update
sudo ln -s "$HOME/dotfiles/pure/pure.zsh" "/usr/local/share/zsh/site-functions/prompt_pure_setup"
sudo ln -s "$HOME/dotfiles/pure/async.zsh" "/usr/local/share/zsh/site-functions/async"
