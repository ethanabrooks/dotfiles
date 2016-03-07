#!/bin/bash -ue

cd ~
# download thoughbot dotfiles
git clone git@github.com:thoughtbot/dotfiles.git
# download vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# create symlinks in ~
./link-config.bash
# install plugins
vim -E -c "PlugInstall" -c "qa!"
