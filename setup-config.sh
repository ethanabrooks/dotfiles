#!/bin/bash -ue

cd ~

# download thoughbot dotfiles
if ! [[ -e ~/dotfiles ]]  # check if already downloaded
then
  git clone git@github.com:thoughtbot/dotfiles.git
fi

# create symlinks in ~
./link-config.bash

# download vim-plug
if ! [[ -e ~/.vim/autoload/plug.vim ]]  # check if already downloaded
then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install plugins
vim -E -c "PlugInstall" -c "qa!"
