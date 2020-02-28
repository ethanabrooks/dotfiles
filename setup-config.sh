#!/bin/bash -ue

YELLOW='\e[33m'
NORMAL='\e[0m'

function print() {
  echo -e "$YELLOW$1$NORMAL"
}

# print "Do you have root privileges? [y|n]"
# read privileged

sudo apt-get update || :
sudo apt-get install -y \
curl \
zsh \
python-pip \
python3-pip \
python-dev \
python3-dev \
tree \
meld \
xclip \
i3 \
silversearcher-ag \
neovim \
mlocate \
terminator 
sudo pip install --upgrade pip virtualenvwrapper
mkdir -p "$HOME/virtualenvs"

print 'Cloning zsh-syntax-highlighting...'
git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$HOME/zsh-syntax-highlighting" || :
chsh -s "$(which zsh)" || :

print 'Linking local dotfiles'
bash "$HOME/dotfiles/link-config.sh"

print 'Downloading vim-plug...'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

print 'Installing vim plugins...'
vim +PlugInstall +qall

mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fpath+=("$HOME/.zsh/pure")

GREEN='\033[0;32m'
print "${GREEN}All done! Congratulations, your system is all setup."
zsh

