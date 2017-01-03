#!/bin/bash -ue

local_dotfiles=$PWD
cd ~

echo 'Downloading thoughtbot dotfiles...'
if ! [[ -e ~/dotfiles ]]  # check if already downloaded
then
  git clone git@github.com:thoughtbot/dotfiles.git
fi


echo 'Do you want to use zsh for your shell? [y|n]'
read want_zsh
if [[ $want_zsh == 'y' ]]; then
  zsh_path="$(which zsh || '')"
fi

echo 'add ssh to git? [y|n]'
read add_ssh

if [[ $add_ssh == 'y' ]]; then
  email="$(git config user.email)"
  ssh-keygen -t rsa -b 4096 -C $email
  eval "$(ssh-agent -s)"
  ssh-add $HOME/.ssh/id_rsa
fi

if [[ "$(uname)" == 'Linux'  ]]; then 
  echo 'Detected platform as Linux'

  if [[ $want_zsh == 'y' ]]; then
    if [[ $zsh_path == '' ]]; then
      echo 'Downloading zsh...'
      sudo apt-get install zsh
    fi
  fi
  PKG_OK=$(dpkg-query -W --showformat='${Status}' rcm)
  echo "Checking for rcm: $PKG_OK"
  if [ '' == "$PKG_OK" ]; then
    echo 'rcm not installed. Downloading...'
    sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
    sudo apt-get update
    sudo apt-get install rcm
  fi
elif [[ "$(uname)" == 'Darwin'  ]]; then 
  echo 'Detected platform as OS X'
  echo 'downloading rcm'
  brew tap thoughtbot/formulae
  brew install rcm
fi

echo 'Symlinking dotfiles'
env RCRC=$HOME/dotfiles/rcrc rcup

if [[ $want_zsh == 'y' ]]; then
  if [[ $(ps | grep zsh) == '' ]]; then
    echo 'Changing shell to zsh'
    chsh -s $zsh_path
  fi

  echo 'Downloading oh-my-zsh...'
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  echo 'Downloading zsh-syntax-highlighting...'
  if ! [[ -e ~/zsh-syntax-highlighting ]]  # check if already downloaded
  then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
  fi
elif [[ $want_zsh == 'n' && $(ps | grep bash) == '' ]]; then
  echo 'Changing shell to bash'
  chsh -s "$(which bash)"
else
  echo 'Did not understand whether you want zsh. Leaving shell as is.'
fi


echo "Generating symlinks in $HOME"
$local_dotfiles/link-config.sh

echo 'Downloading vim-plug...'
if ! [[ -e ~/.vim/autoload/plug.vim ]]  # check if already downloaded
then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo 'Installing plugins'
vim -c PluginInstall -c qall

if [[ $add_ssh == 'y' ]]; then
  echo "Copying SSH key to clipboard:"
  if [[ "$(uname)" == 'Linux'  ]]; then 
    PKG_OK=$(dpkg-query -W --showformat='${Status}' xclip)
    echo "Checking for xclip: $PKG_OK"
    if [ '' == "$PKG_OK" ]; then
      echo 'xclip not installed. Downloading...'
      sudo apt-get install xclip
    fi
    xclip -sel clip < ~/.ssh/id_rsa.pub
  elif [[ "$(uname)" == 'Darwin'  ]]; then 
    pbcopy < ~/.ssh/id_rsa.pub
  fi
fi

source $HOME/.bashrc
GREEN='\033[0;32m'
printf "${GREEN}All done! Congratulations, your system is all setup."
