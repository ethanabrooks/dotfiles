FROM ubuntu

RUN mkdir /root/local-dotfiles/
RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y sudo
RUN apt-get install -y \
      software-properties-common \
      python-software-properties
RUN add-apt-repository -y ppa:martin-frost/thoughtbot-rcm
RUN apt-get update
RUN apt-get install -y ssh zsh rcm curl vim
COPY ./ /root/local-dotfiles/
WORKDIR /root/local-dotfiles/


