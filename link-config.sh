#!/bin/bash -ue

function search-dotfiles {
echo "find ~/dotfiles$1 -maxdepth 1"
}
$(search-dotfiles '')
myconfig=$($(search-dotfiles -local) -type f -not -name '*.sh') # mine
dotfiles=$($(search-dotfiles) -name '*rc' -or -name '*rc.*') # thoughtbot's
files="$myconfig $dotfiles"

for file in $files
do
  echo ln -f -s $file ~/.$(basename $file)
done

