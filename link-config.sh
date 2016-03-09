#!/bin/bash -ue


dotfiles=$HOME/dotfiles

search-dotfiles() {
  echo "find $dotfiles$1 -maxdepth 1"
}
dotfiles_local=$(search-dotfiles -local)
echo $dotfiles_local
myconfig=$($dotfiles_local -not -name '*.sh' -type f) # mine
theirconfig=$($(search-dotfiles '') -name '*rc' -or -name '*rc.*') # thoughtbot's
files="$myconfig $theirconfig"

for file in $files
do
  ln -f -s $file $HOME/.$(basename $file)
done

# link dotfiles-local/bin
ln -f -s $HOME/dotfiles-local/bin $HOME/bin

# if bin is not in path, add it
if [[ $SHELL == "/bin/bash" ]] && [[ ":$PATH:" != *":$HOME/bin:"* ]]
then
  echo 'export PATH=$HOME/bin:$PATH' >> $HOME/.bashrc
fi
