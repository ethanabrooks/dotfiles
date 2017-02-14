#!/bin/bash -ue

cd $HOME

base_dir="$HOME/local-dotfiles"

myconfig=$(find $base_dir -maxdepth 1 -type f -not -name '*.sh')  # mine
dotfiles=$(find dotfiles -maxdepth 1 -name '*rc' -or -name '*rc.*')  # thoughtbot's
files="$myconfig $dotfiles"

for file in $files
do
 ln -f -s $file $HOME/.$(basename $file)
 echo "ln -f -s $file $HOME/.$(basename $file)"
done

dirs="$base_dir/kwm $base_dir/git"

for dir in $dirs 
do
  ln -s -f $dir $HOME/.$(basename $dir)
  echo "ln -s -f $dir $HOME/.$(basename $dir)"
done
