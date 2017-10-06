dotfiles="$HOME/dotfiles"
export PATH="\
/usr/local/bin:\
$HOME/.local/bin:\
$dotfiles/bin:\
/usr/local/bin:\
$PATH\
"

export CELLAR='/usr/local/Cellar/'

# export MANPATH="/usr/local/man:$MANPATH"

# virtualenvwrapper
export WORKON_HOME="$HOME/virtualenvs"
source '/usr/local/bin/virtualenvwrapper.sh'

# exports
export bin="$dotfiles/bin/"
export zshrc="$HOME/.zshrc"
export eab='/google/src/cloud/ethanabrooks/ethan/google3/experimental/users/ethanabrooks/'
export pv="$eab/placevault"
export VISUAL=vim

fpath=($fpath $dotfiles/pure)

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
plugins=(git zsh-syntax-highlighting)

# User configurationw
bindkey -v
bindkey '^R' history-incremental-search-backward

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# aliases
alias zshrc="vi $zshrc"
alias vimrc='vi ~/.vimrc'
alias xinitrc="vi ~/.xinitrc"
alias sovim='source ~/.vimrc'
alias bundles='vi ~/.vimrc.bundles'
alias ignore-untracked="git status --porcelain | grep '^??' | cut -c4- >> .gitignore"
alias install-tensorflow="pip install --upgrade $TF_BINARY_URL"
alias commit="git commit -am $@"
alias i3config="vi ~/.config/i3/config"
alias vi=nvim
alias ls='ls --color'
alias pacman='sudo pacman'
alias wifi='sudo wifi-menu'

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
#source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

# pure
autoload -U promptinit; promptinit
prompt pure

# zsh syntax highlighting
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# source z
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

setopt autocd
setopt autopushd
setopt inc_append_history
setopt inc_append_history
setopt share_history

# History
setopt APPEND_HISTORY          # append rather than overwrite history file.
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information
HISTFILE=$HOME/.zhistory       # enable history saving on shell exit
HISTSIZE=1200                  # lines of history to maintain memory
SAVEHIST=1000                  # lines of history to maintain in history file.

autoload -U compinit
compinit

# Go
export GOPATH=~/go
PATH=$PATH:$GOPATH/bin
source /opt/ros/indigo/setup.zsh

network_if=em1

if [ -e /opt/tmc/ros/indigo/setup.zsh ] ; then
  export TARGET_IP=$(LANG=C /sbin/ifconfig $network_if | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*')
  if [ -z "$TARGET_IP" ] ; then
    echo "ROS_IP is not set."
  else
    export ROS_IP=$TARGET_IP
  fi
  export ROS_HOME=~/.ros
  alias sim_mode='export ROS_MASTER_URI=http://localhost:11311 export PS1="\[\033[44;1;37m\]<local>\[\033[0m\]\w$ "'
  alias hsrb_mode='export ROS_MASTER_URI=http://hsrb.local:11311 export PS1="\[\033[41;1;37m\]<hsrb>\[\033[0m\]\w$ "'
  source /opt/tmc/ros/indigo/setup.zsh
fi
