#!/bin/bash -ue

git clone https://github.com/tomislav/osx-terminal.app-colors-solarized.git

cd ~

# download thoughbot dotfiles
git clone git@github.com:thoughtbot/dotfiles.git

sh -c "$(wget
https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
-O -)"

# create symlinks in ~
./dotfiles-local/link-config.sh

# download vim-plug
if ! [[ -e ~/.vim/autoload/plug.vim ]]  # check if already downloaded
then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install plugins
vim -E -c "PlugInstall" -c "qa!"
