#!/bin/bash

#yay -S python-ueberzug-git
mkdir ~/.config/ranger
#mkdir ~/.config/ranger/plugins
#git clone https://github.com/alexanderjeurlssen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
cp rc.conf ~/.config/ranger/
sed -i '12 i \ \ \ \ \" Ranger' ~/.config/nvim/vim-plug/plugins.vim
sed -i "13 i \ \ \ \ Plug 'kevinhwang91/rnvimr', { 'do': 'make sync' }" ~/.config/nvim/vim-plug/plugins.vim
mkdir ~/.config/nvim/plug-config
cp rnvimr.vim ~/.config/nvim/plug-config/
echo 'source $HOME/.config/nvim/plug-config/rnvimr.vim' >> ~/.config/nvim/init.vim
echo "Neovim will open in 5 sec, when there type ':PlugInstall'"
sleep 5
nvim
