#!/bin/bash

mkdir -p ~/.config/
mkdir ~/.config/nvim/
touch ~/.config/nvim/init.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.config/nvim/vim-plug/
cp plugins.vim ~/.config/nvim/vim-plug/
echo 'source $HOME/.config/nvim/vim-plug/plugins.vim' > ~/.config/nvim/init.vim
echo 'nvim will open in 10 sec, when there type `:PlugStatus` to check the status of
plugins or type `:PlugInstall` immediately to install them'
sleep 10
nvim
