#!/bin/bash -ue

cd $HOME

base_dir="$HOME/local-dotfiles"

files=$(find $base_dir -maxdepth 1 -type f -not -name '*.sh')

for file in $files
do
 ln -fs $file $HOME/.$(basename $file)
 echo "ln -fs $file $HOME/.$(basename $file)"
done

dirs="$base_dir/git $base_dir/config"

for dir in $dirs 
do
  ln -sf $dir $HOME/.$(basename $dir)
  echo "ln -sf $dir $HOME/.$(basename $dir)"
done
