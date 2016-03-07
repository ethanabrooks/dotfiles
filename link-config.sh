#!/bin/bash -ue

myconfig=$(find . ! -name '*.sh' ! -name '.*' -depth 1)  # mine
dotfiles=$(ls ~/dotfiles/*rc{,.*})  # thoughtbot's
files=$myconfig$dotfiles

for file in $files
do
  #echo $file 
  ln -f -s $file ~/.$(basename $file)
done

