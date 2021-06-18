#!/bin/bash -ue

YELLOW='\e[33m'
NORMAL='\e[0m'

function print() {
  echo -e "$YELLOW$1$NORMAL"
}

sudo apt-get update || :
sudo apt-get install -y \
curl \
zsh \
python3-pip \
python3-dev \
tree \
silversearcher-ag \
neovim \
mlocate


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

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install --global pure-prompt

GREEN='\033[0;32m'
print "${GREEN}All done! Congratulations, your system is all setup."
zsh

