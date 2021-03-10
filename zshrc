path+=(
$HOME/.local/bin
$HOME/dotfiles/bin
/usr/local/bin
/usr/local/bin
/usr/local/opt/findutils/libexec/gnubin
)

# poetry
fpath+=~/.zfunc

# exports
export vimrc="$config/nvim/init.vim"

# aliases
alias zshrc="vi $HOME/.zshrc"
alias vimrc="vi $HOME/.config/nvim/init.vim"
alias vi=nvim

# pure
autoload -U promptinit; promptinit
prompt pure


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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ethanbrooks/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ethanbrooks/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ethanbrooks/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ethanbrooks/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
function chpwd {
  ls
  echo $(pwd) >! $CURRENT_PROJECT_PATH
  test -e environment.yml && eval "conda activate $(cat environment.yml | yq eval '.name' -)"
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
function wtf { 
  HYDRA_FULL_ERROR=1 python -m ipdb -c continue $@
}

export LDFLAGS="-L/usr/local/opt/libffi/lib"
export CPPFLAGS="-I/usr/local/opt/libffi/include"
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
export PYTHONBREAKPOINT="ipdb.set_trace"


export PATH="$HOME/.poetry/bin:$PATH"

PATH="/Users/ethanbrooks/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL_MB_OPT="--install_base \"/Users/ethanbrooks/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/ethanbrooks/perl5"; export PERL_MM_OPT;

# opam configuration
test -r /Users/ethanbrooks/.opam/opam-init/init.zsh && . /Users/ethanbrooks/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

eval "$(direnv hook zsh)"

