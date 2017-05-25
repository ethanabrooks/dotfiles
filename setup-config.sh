#!/bin/bash -ue

local_dotfiles=$PWD
cd ~

YELLOW='\e[33m'
NORMAL='\e[0m'

function print() {
  echo -e "$YELLOW$1$NORMAL"
}

print 'Linking local dotfiles'
bash $local_dotfiles/link-config.sh

print 'Downloading vim-plug...'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

print 'Cloning gruvbox'
git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox || :

# hack to fix file encoding in vimrc
sed -i '1iset encoding=utf-8\nsetglobal fileencoding=utf-8' $HOME/.vimrc

print 'Installing vim plugins...'
vim -c PlugInstall -c qall

print "Do you have root privileges? [y|n]"
read privileged

# zsh stuff
if [[ $privileged == 'y' ]]; then
  sudo apt update
  sudo apt -y install python-pip silversearcher-ag tree
  sudo pip install virtualenvwrapper
  mkdir -p virtualenvs

  print 'Cloning zsh-syntax-highlighting...'
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git || :

  chsh -s $(which zsh)

  print 'Downloading oh-my-zsh...'
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || :
fi


GREEN='\033[0;32m'
print "${GREEN}All done! Congratulations, your system is all setup."
zsh

