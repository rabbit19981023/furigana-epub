FROM rust:latest

# install NeoVim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
  chmod u+x nvim.appimage && \
  ./nvim.appimage --appimage-extract && \
  ln -s /squashfs-root/AppRun /usr/bin/nvim

# set default shell to bash for NeoVim
ENV SHELL=bash

# install ripgrep for Telescope.nvim
RUN apt-get update && apt-get install -y ripgrep

# install LazyVim (NeoVim Distro)
RUN git clone https://github.com/LazyVim/starter ~/.config/nvim

# install tmux (a simple hack to copy/paste from inside container to localhost clipboard)
# NOTE: you also need install tmux in localhost, and mount localhost's `/tmp/tmux-1000/default` into container
RUN apt-get install -y tmux
ENV TMUX=/tmp/tmux-1000/default

# install wasm-pack for wasm dev workflow
RUN cargo install wasm-pack
