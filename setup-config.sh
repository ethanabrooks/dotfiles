#!/bin/bash -ue

YELLOW='\e[33m'
NORMAL='\e[0m'

function print() {
  echo -e "$YELLOW$1$NORMAL"
}

# print "Do you have root privileges? [y|n]"
# read privileged
privileged='y'

if [[ $privileged == 'y' ]]; then
  sudo pacman -Sy --noconfirm \
    curl \
    zsh \
    python-pip \
    tree \
    meld \
    xclip \
    i3 \
    the_silver_searcher \
    gvim \
    neovim \
    termite
  sudo pip install --upgrade pip virtualenvwrapper
  mkdir -p "$HOME/virtualenvs"

  print 'Cloning zsh-syntax-highlighting...'
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/zsh-syntax-highlighting" || :
  chsh -s "$(which zsh)"
fi

print 'Linking local dotfiles'
bash "$HOME/dotfiles/link-config.sh"

print 'Downloading vim-plug...'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

print 'Installing vim plugins...'
vim -c PlugInstall -c qall

GREEN='\033[0;32m'
print "${GREEN}All done! Congratulations, your system is all setup."
zsh

