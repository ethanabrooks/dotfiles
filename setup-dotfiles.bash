#!/bin/bash -ue

cd ~
git clone git@github.com:thoughtbot/dotfiles.git

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

files=$(ls ~/dotfiles-local/*.local; ls ~/dotfiles/*rc{,.*})

#files=$(ls ~/dotfiles/*rc)
for file in $files
do
#  echo $file
   ln -f -s $file ~/.$(basename $file)
done

vim -E -c "PlugInstall" -c "qa!"

