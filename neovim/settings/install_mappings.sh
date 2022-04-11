#!/bin/bash

mkdir ~/.config/nvim/keys/
cp mappings.vim ~/.config/nvim/keys/
echo 'source $HOME/.config/nvim/keys/mappings.vim' >> ~/.config/nvim/init.vim
