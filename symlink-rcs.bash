#!/bin/bash -ue

files=$(ls ~/dotfiles-local/*.local; ls ~/dotfiles/*rc{,.*})

#files=$(ls ~/dotfiles/*rc)
for file in $files
do
#  echo $file
   ln -f -s $file ~/.$(basename $file)
done
