#!/bin/bash -ue

local_dotfiles=$PWD
cd ~

YELLOW='\e[33m'
NORMAL='\e[0m'

function print() {
  echo -e "$YELLOW$1$NORMAL"
}

print "Do you have root privileges? [y|n]"
read privileged

if [[ $privileged == 'y' ]]; then
  if [[ "$(uname)" == 'Linux' ]]; then
    sudo apt-get update
    sudo apt-get install -y \
      software-properties-common \
      python-software-properties
    sudo add-apt-repository -y ppa:martin-frost/thoughtbot-rcm
    sudo apt-get update
    sudo apt-get install -y ssh zsh rcm 
  elif [[ "$(uname)" == 'Darwin' ]]; then
    brew tap thoughtbot/formulae
    brew install rcm zsh
  fi
fi

print 'Cloning thoughtbot dotfiles...'
git clone https://github.com/thoughtbot/dotfiles.git || :
env RCRC=$HOME/dotfiles/rcrc rcup
bash $local_dotfiles/link-config.sh

print 'Downloading vim-plug...'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

print 'Cloning gruvbox'
git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox

# hack to fix file encoding in vimrc
sed -i '1iset encoding=utf-8\nsetglobal fileencoding=utf-8' $HOME/.vimrc

print 'Installing vim plugins...'
vim -c PlugInstall -c qall

print 'Cloning zsh-syntax-highlighting...'
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git || :

#print 'Sourcing zshrc...'
if [[ $privileged == 'y' ]]; then
  chsh -s $(which zsh)
fi
zsh

print 'Downloading oh-my-zsh...'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || :

GREEN='\033[0;32m'
print "${GREEN}All done! Congratulations, your system is all setup." TODO
