#!/bin/bash -ue

YELLOW='\e[33m'
NORMAL='\e[0m'

function print() {
  echo -e "$YELLOW$1$NORMAL"
}

# print "Do you have root privileges? [y|n]"
# read privileged
privileged='y'

if [[ $privileged == 'y' ]]; then
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
  sudo add-apt-repository -y ppa:neovim-ppa/stable
  sudo apt-get update
  sudo apt-get install -y \
    curl \
    zsh \
    python-pip \
    python3-pip \
    python-dev \
    python3-dev \
    tree \
    meld \
    xclip \
    i3 \
    silversearcher-ag \
    vim-gnome \
    neovim \
    terminator \
    google-chrome-stable
  sudo pip install --upgrade pip virtualenvwrapper
  mkdir -p "$HOME/virtualenvs"

  print 'Cloning zsh-syntax-highlighting...'
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/zsh-syntax-highlighting" || :
  chsh -s "$(which zsh)"
fi

print 'Linking local dotfiles'
bash "$HOME/dotfiles/link-config.sh"

print 'Downloading vim-plug...'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# hack to fix file encoding in vimrc
print 'Setting encodings to utf-8...'
sed -i '1iscriptencoding utf-8\nset encoding=utf-8' "/home/ethanbro/.config/nvim/init.vim"

print 'Installing vim plugins...'
vim -c PlugInstall -c qall

GREEN='\033[0;32m'
print "${GREEN}All done! Congratulations, your system is all setup."
zsh

