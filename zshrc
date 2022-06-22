# exports
export vimrc="$config/nvim/init.vim"

export DOCKER_BUILDKIT=1

# aliases
alias zshrc="vi $HOME/.zshrc"
alias vimrc="vi $HOME/.config/nvim/init.vim"
alias vi=nvim


# https://unix.stackexchange.com/a/113768
#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM"
#=~ tmux ]] && [ -z "$TMUX" ]; then
  #exec tmux
#fi

# pure
autoload -U promptinit; promptinit
prompt pure

function chpwd {
  ls
  echo $(pwd) >! $CURRENT_PROJECT_PATH
  test -e environment.yml && eval "conda activate $(cat environment.yml | yq eval '.name' -)"
  #test -e pyproject.toml && poetry shell
  if [[  -e env.sh  ]]; then 
    source env.sh
    cat env.sh
  fi
}
chpwd

# match from middle of filename
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit

# reverse search
bindkey -v
bindkey '^R' history-incremental-search-backward

# History
setopt APPEND_HISTORY          # append rather than overwrite history file.
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information
setopt share_history           # share between terminal sessions
HISTFILE=$HOME/.zhistory       # enable history saving on shell exit
HISTSIZE=1200                  # lines of history to maintain memory
SAVEHIST=1000                  # lines of history to maintain in history file.

plugins=(git zsh-syntax-highlighting)

set -o vi # vim keybindings
setopt autopushd # use directory stack
setopt autocd # implicit cd
autoload zmv

# save last visited dir
export CURRENT_PROJECT_PATH=$HOME/.current-project
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

function wtf { 
  HYDRA_FULL_ERROR=1 python -m ipdb -c continue $@
}

function wtf { 
  HYDRA_FULL_ERROR=1 python -m ipdb -c continue $@
}

export LDFLAGS="-L/usr/local/opt/libffi/lib"
export CPPFLAGS="-I/usr/local/opt/libffi/include"
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
export PYTHONBREAKPOINT="ipdb.set_trace"


# opam configuration
test -r /Users/ethanbrooks/.opam/opam-init/init.zsh && . /Users/ethanbrooks/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

eval "$(direnv hook zsh)"
eval "$(nodenv init -)"
eval "$(rbenv init - zsh)"

export PATH="$HOME/.poetry/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
