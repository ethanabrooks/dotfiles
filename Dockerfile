FROM ubuntu

RUN apt-get update
RUN apt-get install -y sudo curl git
COPY test.txt /root
COPY local-dotfiles /root/dotfiles
WORKDIR /root
