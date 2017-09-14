FROM ubuntu

RUN apt-get update
RUN apt-get install -y sudo curl git
RUN apt-get install -y vim-gnome zsh python-pip silversearcher-ag tree terminator
COPY dotfiles /root/dotfiles
WORKDIR /root/dotfiles
