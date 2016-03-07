#!/bin/bash -ue

cd ~
# download thoughbot dotfiles
git clone git@github.com:thoughtbot/dotfiles.git
# create symlinks in ~
./link-config.bash
# download vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# install plugins
vim -E -c "PlugInstall" -c "qa!"
