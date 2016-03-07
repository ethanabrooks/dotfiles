#!/bin/bash -ue

myconfig=$(find dotfiles-local -maxdepth 1 -type f -not -name '*.sh')  # mine
dotfiles=$(find dotfiles -maxdepth 1 -name '*rc' -or -name '*rc.*')  # thoughtbot's
files="$myconfig $dotfiles"

for file in $files
do
  ln -f -s $file ~/.$(basename $file)
done

