#!/bin/bash

sed -i '9 i \ \ \ \ \" Status Line' ~/.config/nvim/vim-plug/plugins.vim
sed -i "10 i \ \ \ \ Plug 'vim-airline/vim-airline'" ~/.config/nvim/vim-plug/plugins.vim
sed -i "11 i \ \ \ \ Plug 'vim-airline/vim-airline-themes'" ~/.config/nvim/vim-plug/plugins.vim
echo "Neovim will open in 5 sec to install the plugins, type ':PlugInstall'"
sleep 5
nvim
