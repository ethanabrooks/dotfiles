# Path to your oh-my-zsh installation.
local_dotfiles="$HOME/local-dotfiles"
export PATH=/usr/local/bin:$HOME/.local/bin:$local_dotfiles/bin:/usr/local/bin:$PATH
export CELLAR='/usr/local/Cellar/'

# export MANPATH="/usr/local/man:$MANPATH"

# virtualenvwrapper
export WORKON_HOME="$HOME/virtualenvs"
source /usr/local/bin/virtualenvwrapper.sh

# aliases
export bin="$local_dotfiles/bin/"
export zshrc="$HOME/.zshrc"

fpath=($fpath $local_dotfiles/pure)

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# vim please!
bindkey -v

local_dotfiles="$HOME/local-dotfiles"

# aliases
alias zshrc="vi $zshrc"
alias vimrc='vi ~/.vimrc'
alias sovim='source ~/.vimrc'
alias bundles='vi ~/.vimrc.bundles'
alias ignore-untracked="git status --porcelain | grep '^??' | cut -c4- >> .gitignore"
alias install-tensorflow="pip install --upgrade $TF_BINARY_URL"
alias commit="git commit -am $@"
alias i3config="vi ~/.config/i3/config"
#alias ls='ls --color'

# save last visited dir
export CURRENT_PROJECT_PATH=$HOME/.current-project
function chpwd {
  ls
  echo $(pwd) >! $CURRENT_PROJECT_PATH
}
function current {
  if [[ -f $CURRENT_PROJECT_PATH  ]]; then 
    cd "$(cat $CURRENT_PROJECT_PATH)"
  fi
}
current

# pretty vi
source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"


# pure
autoload -U promptinit; promptinit
prompt pure

# zsh syntax highlighting
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh

# source z
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'


# improve ag tab completion
#if (( CURRENT == 2 )); then
  #compadd $(cut -f 1 tmp/tags .git/tags 2>/dev/null)
#else;
  #_files
#fi
