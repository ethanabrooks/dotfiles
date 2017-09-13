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
  string="$(cat /etc/*-release | grep '^NAME=')"
  tmp=${string#*\"}  # remove prefix ending in "
  distro=${tmp%\"*}  # remove suffix starting with "
  if [[ $distro =~ 'Arch Linux' ]]
  then
    sudo pacman -Sy curl gvim zsh python-pip the_silver_searcher tree termite
  elif [[ $distro =~ 'Ubuntu' ]]
  then
    sudo apt-get install -y vim-gnome zsh python-pip silversearcher-ag tree terminator
  else
    echo "This script does not support $distro."
    exit
  fi
  sudo pip install virtualenvwrapper
  mkdir -p "$HOME/virtualenvs"

  print 'Cloning zsh-syntax-highlighting...'
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/zsh-syntax-highlighting" || :

  chsh -s "$(which zsh)"

fi

print 'Downloading vim-plug...'
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

print 'Cloning gruvbox'
git clone https://github.com/morhetz/gruvbox.git "$HOME/.vim/bundle/gruvbox" || :

# hack to fix file encoding in vimrc
print 'Setting encodings to utf-8...'
sed -i '1iscriptencoding utf-8\nset encoding=utf-8' "$HOME/.vimrc"

exit
print 'Installing vim plugins...'
vim -c PlugInstall -c qall

print 'Linking local dotfiles'
bash "$HOME/dotfiles/link-config.sh"

GREEN='\033[0;32m'
print "${GREEN}All done! Congratulations, your system is all setup."
zsh

