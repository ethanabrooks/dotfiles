#!/bin/bash -ue

cd ~

default_email="ethanabrooks@gmail.com"
default_name="Ethan Brooks"

echo "What email do you want to use for git? [default: $default_email]"
read email
email=${email:-"$default_email"}

git config --global user.email $email

echo "What name do you want to use for git? [default: $default_name]"
read name
name=${name:-"$default_name"}
git config --global user.name $name


echo "Downloading thoughtbot dotfiles..."
if ! [[ -e ~/dotfiles ]]  # check if already downloaded
then
  git clone git@github.com:thoughtbot/dotfiles.git
fi


echo "Do you want to use zsh for your shell? [y|n]"
read want_zsh
zsh_path="$(which zsh)"

echo "add ssh to git? [y|n]"
read add_ssh

if [[ $add_ssh == 'y' ]]; then
  ssh-keygen -t rsa -b 4096 -C $email
  eval "$(ssh-agent -s)"
  ssh-add $HOME/.ssh/id_rsa
fi

if [[ "$(uname)" == 'Linux'  ]]; then 
  echo "Detected platform as Linux"

  if [[ $want_zsh == 'y' ]]; then
    if [[ $zsh_path == '' ]]; then
      echo "Downloading zsh..."
      sudo apt-get install zsh
    fi
  fi
  echo "downloading rcm"
  sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
  sudo apt-get update
  sudo apt-get install rcm

elif [[ "$(uname)" == 'Darwin'  ]]; then 
  echo "Detected platform as OS X"
  echo "downloading rcm"
  brew tap thoughtbot/formulae
  brew install rcm
fi

echo "Symlinking dotfiles"
env RCRC=$HOME/dotfiles/rcrc rcup

if [[ $want_zsh == 'y' ]]; then
  echo "Changing shell to zsh"
  chsh -s $zsh_path

  echo "Downloading oh-my-zhs..."
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
elif [[ $want_zsh == 'n' ]]; then
  echo "Changing shell to bash"
  chsh -s "$(which bash)"
else
  echo "Did not understand whether you want zsh. Leaving shell as is."
fi


echo "Generating symlinks in $HOME"
./local-dotfiles/link-config.sh

echo "Downloading vim-plug..."
if ! [[ -e ~/.vim/autoload/plug.vim ]]  # check if already downloaded
then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim -E -c "PlugInstall" -c "qa!"

if [[ $add_ssh == 'y' ]]; then
  echo "Command to copy SSH key to clipboard:"
  if [[ "$(uname)" == 'Linux'  ]]; then 
    sudo apt-get install xclip
    echo "xclip -sel clip < ~/.ssh/id_rsa.pub"
  elif [[ "$(uname)" == 'Darwin'  ]]; then 
    echo "pbcopy < ~/.ssh/id_rsa.pub"
  fi
fi
