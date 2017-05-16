#!/bin/bash -ue

cd $HOME

base_dir="$HOME/local-dotfiles"

myconfig=$(find $base_dir -maxdepth 1 -type f -not -name '*.sh')  # mine
dotfiles=$(find dotfiles -maxdepth 1 -name '*rc' -or -name '*rc.*')  # thoughtbot's
files="$myconfig $dotfiles"

for file in $files; do
 ln -i -s $file $HOME/.$(basename $file)
 echo "linked $file"
done

dirs=( i3 ssh )
dirs=( "${dirs[@]/#/$base_dir/}" )  # prepend base_dir
for dir in ${dirs[@]}; do
  dst_dir=$HOME/.$(basename $dir)
  if [[ -d "$dst_dir" ]]; then
    echo "$dst_dir already exists. Linking contents"
    for file in $(ls $dir); do
      ln -s -i $dir/$file $dst_dir/$file
      echo "linked $file"
    done
  else
    ln -s -i $dir $dst_dir
    echo "linked $dir"
  fi
done
