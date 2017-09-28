FROM base/archlinux

RUN pacman -Sy --noconfirm sudo curl git
RUN pacman -Sy --noconfirm curl gvim zsh python-pip the_silver_searcher tree termite
COPY dotfiles /root/dotfiles
WORKDIR /root/dotfiles
