FROM base/archlinux

RUN pacman -Sy --noconfirm sudo curl git
RUN pacman -Sy --noconfirm \
      curl \
      gvim \
      neovim \
      zsh \
      python-pip \
      the_silver_searcher \
      tree \
      termite
COPY . /root/dotfiles
WORKDIR /root/dotfiles
