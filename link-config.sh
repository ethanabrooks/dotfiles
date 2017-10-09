#!/bin/bash -ue

base_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

files=$(find "$base_dir" -maxdepth 1 -type f -not -name '*.sh')

for file in $files
do
  ln -fs "$file" "$HOME/.$(basename "$file")"
done


dirs=""  # may add some in the future

for dir in $dirs 
do
  dst="$HOME/.$(basename $dir)"
  if [ ! -d "$dst" ]
  then
    ln -sf "$base_dir"/"$dir" "$dst"
  fi
done

configs="i3 terminator nvim"
mkdir -p "$HOME/.config"

for config in $configs 
do
  dst="$HOME/.config/$(basename "$config")"
  if [ ! -d "$dst" ]
  then
    ln -sf "$base_dir"/"$config" "$dst"
  fi
done
