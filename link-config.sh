#!/bin/bash -ue

base_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

files=$(find "$base_dir" -maxdepth 1 -type f -not -name '*.sh')

for file in $files
do
  ln -fs "$file" "$HOME/.$(basename "$file")"
done

dirs="git"

for dir in $dirs 
do
  ln -sf "$base_dir"/"$dir" "$HOME/.$(basename $dir)"
done

configs="i3 polybar termite"

for config in $configs 
do
  ln -sf "$base_dir"/"$config" "$HOME/.config/$(basename "$config")"
done
