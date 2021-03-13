export PATH="$HOME/.poetry/bin:$PATH"

# save last visited dir
export CURRENT_PROJECT_PATH=$HOME/.current-project
function current {
  cat $CURRENT_PROJECT_PATH
  if [[ -f $CURRENT_PROJECT_PATH  ]]; then
    cd "$(cat $CURRENT_PROJECT_PATH)"
  fi
}
current

function chpwd {
  ls
  echo $(pwd) >! $CURRENT_PROJECT_PATH
  test -e environment.yml && eval "conda activate $(cat environment.yml| yq e .name  -)"
  test -e pyproject.toml && poetry shell

  if [[  -e env.sh  ]]; then 
    source env.sh
    cat env.sh
  fi
}
chpwd
