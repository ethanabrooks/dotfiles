#!/bin/bash -ue

base_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

files=$(find $base_dir -maxdepth 1 -type f -not -name '*.sh')

for file in $files
do
 ln -fs $file $HOME/.$(basename $file)
 echo "ln -fs $file $HOME/.$(basename $file)"
done

dirs="$base_dir/git"

for dir in $dirs 
do
  ln -sf $dir $HOME/.$(basename $dir)
  echo "ln -sf $dir $HOME/.$(basename $dir)"
done

configs="$base_dir/i3 $base_dir/"
