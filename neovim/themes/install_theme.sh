#!/bin/bash

sed -i '7 i \ \ \ \ \" Themes' ~/.config/nvim/vim-plug/plugins.vim
#sed -i "8 i \ \ \ \ Plug 'joshdick/onedark.vim'" ~/.config/nvim/vim-plug/plugins.vim
#sed -i "8 i \ \ \ \ Plug 'shaunsingh/nord.nvim'" ~/.config/nvim/vim-plug/plugins.vim
sed -i "8 i \ \ \ \ Plug 'folke/tokyonight.nvim', { 'branch': 'main' }" ~/.config/nvim/vim-plug/plugins.vim
echo "Neovim will open in 5 sec, when there type ':PlugInstall' to install a theme"
sleep 5
nvim
