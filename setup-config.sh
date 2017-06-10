#!/bin/bash -ue

YELLOW='\e[33m'
NORMAL='\e[0m'

function print() {
  echo -e "$YELLOW$1$NORMAL"
}

print "Do you have root privileges? [y|n]"
#read privileged
privileged='y'

if [[ $privileged == 'y' ]]; then
  sudo pacman -Sy curl vim zsh python-pip the_silver_searcher tree termite
  sudo pip install virtualenvwrapper
  mkdir -p $HOME/virtualenvs

  print 'Cloning zsh-syntax-highlighting...'
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/zsh-syntax-highlighting

  chsh -s $(which zsh)

  #print 'Downloading oh-my-zsh...'
  #sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &
fi

print 'Downloading vim-plug...'
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

print 'Cloning gruvbox'
git clone https://github.com/morhetz/gruvbox.git $HOME/.vim/bundle/gruvbox || :

# hack to fix file encoding in vimrc
#sed -i '1iset encoding=utf-8\nsetglobal fileencoding=utf-8' $HOME/.vimrc

print 'Installing vim plugins...'
vim -c PlugInstall -c qall

print 'Linking local dotfiles'
bash $HOME/dotfiles/link-config.sh

GREEN='\033[0;32m'
print "${GREEN}All done! Congratulations, your system is all setup."
zsh

