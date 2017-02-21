#!/bin/bash -ue

local_dotfiles=$PWD
cd ~

echo 'add ssh to git? [y|n]'
read add_ssh

if [[ $add_ssh == 'y' ]]; then
  echo "bash $local_dotfiles/bin/add-ssh"
  bash $local_dotfiles/bin/add-ssh
fi

source $HOME/.bashrc
GREEN='\033[0;32m'

echo 'Downloading thoughtbot dotfiles...'
if ! [[ -e ~/dotfiles ]]  # check if already downloaded
then
  echo "git clone git@github.com:thoughtbot/dotfiles.git"
  git clone git@github.com:thoughtbot/dotfiles.git
fi


echo 'Do you want to use zsh for your shell? [y|n]'
read want_zsh
if [[ $want_zsh == 'y' ]]; then
  zsh_path="$(which zsh || echo '')"
fi

if [[ "$(uname)" == 'Linux'  ]]; then 
  echo 'Detected platform as Linux'

  if [[ $want_zsh == 'y' ]]; then
    if [[ $zsh_path == '' ]]; then
      echo 'Downloading zsh...'
      sudo apt-get install zsh
      echo 'sudo apt-get install zsh'
    fi
  fi
echo 'Checking for rcm'
rcm_path="$(which rcup || echo '')"
if [ "" == "$rcm_path" ]; then
    echo 'rcm not installed. Downloading...'
    echo 'sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm'
    sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
    echo 'sudo apt-get update'
    sudo apt-get update
    echo 'sudo apt-get --force-yes --yes install rcm'
    sudo apt-get --force-yes --yes install rcm
fi
elif [[ "$(uname)" == 'Darwin'  ]]; then 
    echo 'Detected platform as OS X'
    echo 'downloading rcm'
    echo 'brew tap thoughtbot/formulae'
    brew tap thoughtbot/formulae
    echo 'brew install rcm' 
    brew install rcm
fi

echo 'Symlinking dotfiles'
echo "env RCRC=$HOME/dotfiles/rcrc rcup"
env RCRC=$HOME/dotfiles/rcrc rcup

if [[ $want_zsh == 'y' ]]; then
  if [[ $(ps | grep zsh) == '' ]]; then
    echo 'Changing shell to zsh'
    echo "chsh -s $zsh_path"
    chsh -s $zsh_path
  fi

  echo 'Downloading oh-my-zsh...'
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  echo 'Downloading zsh-syntax-highlighting...'
  if ! [[ -e ~/zsh-syntax-highlighting ]]  # check if already downloaded
  then
    echo 'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git'
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
  fi
elif [[ $want_zsh == 'n' && $(ps | grep bash) == '' ]]; then
  echo 'Changing shell to bash'
  echo "chsh -s $(which bash)"
  chsh -s "$(which bash)"
else
  echo 'Did not understand whether you want zsh. Leaving shell as is.'
fi


echo "Generating symlinks in $HOME"
echo "$local_dotfiles/link-config.sh"
$local_dotfiles/link-config.sh

echo 'Downloading vim-plug...'
if ! [[ -e ~/.vim/autoload/plug.vim ]]  # check if already downloaded
then
  echo 'curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
echo 'source .~/.zshrc'
source .~/.zshrc

echo 'Installing plugins'
echo 'vim -c PluginInstall -c qall'
vim -c PluginInstall -c qall

printf "${GREEN}All done! Congratulations, your system is all setup."
