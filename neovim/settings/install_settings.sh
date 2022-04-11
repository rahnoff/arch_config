#!/bin/bash

mkdir ~/.config/nvim/general/
cp settings.vim ~/.config/nvim/general/
echo 'source $HOME/.config/nvim/general/settings.vim' >> ~/.config/nvim/init.vim
echo 'Neovim will open in 5 sec, when there type `source $MYVIMRC` to install
settings and close it'
sleep 5
nvim
