dotfiles="$HOME/dotfiles"

path+=(
$dotfiles/bin
/snap/bin
/usr/local/bin
$HOME/.local/bin
/usr/local/bin
$HOME/.yarn/bin
/snap/bin
$PATH
)

fpath+=("$HOME/.zsh/pure")

# pure
autoload -U promptinit; promptinit
prompt pure


# save last visited dir
export CURRENT_PROJECT_PATH=$HOME/.current-project
function chpwd {
  ls
  echo $(pwd) >! $CURRENT_PROJECT_PATH
  test -e environment.yml && eval "conda activate $(cat environment.yml| yq e .name  -)"

  if [[  -e env.sh  ]]; then 
    source env.sh
    cat env.sh
  fi
}
function current {
  if [[ -f $CURRENT_PROJECT_PATH  ]]; then
    cd "$(cat $CURRENT_PROJECT_PATH)"
  fi
}
current

if [[ -e $dotfiles/system_specific.zsh ]]; then
  source $dotfiles/system_specific.zsh
fi

