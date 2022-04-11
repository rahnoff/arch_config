#!/bin/bash

# Install Vim-Plug
mkdir ~/.config

mkdir ~/.config/nvim

touch ~/.config/nvim/init.vim

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir ~/.config/nvim/vim-plug

cp plugins.vim ~/.config/nvim/vim-plug/

echo "source $HOME/.config/nvim/vim-plug/plugins.vim" > ~/.config/nvim/init.vim

# Install Settings
mkdir ~/.config/nvim/general

cp settings.vim ~/.config/nvim/general/

echo "source $HOME/.config/nvim/general/settings.vim" >> ~/.config/nvim/init.vim

source "$MYVIMRC"

#Install Mappings
mkdir ~/.config/nvim/keys

cp mappings.vim ~/.config/nvim/keys/

echo "source $HOME/.config/nvim/keys/mappings.vim" >> ~/.config/nvim/init.vim

#Install Themes
sed -i "17 i \ \ \ \ \" Themes" ~/.config/nvim/vim-plug/plugins.vim

sed -i "18 i \ \ \ \ Plug 'joshdick/onedark.vim'" ~/.config/nvim/vim-plug/plugins.vim

mkdir ~/.config/nvim/themes

cp onedark.vim ~/.config/nvim/themes/

echo "source $HOME/.config/nvim/themes/onedark.vim" >> ~/.config/nvim/init.vim

#Install Status Line
sed -i "19 i \ \ \ \ \" Status Line" ~/.config/nvim/vim-plug/plugins.vim

sed -i "20 i \ \ \ \ Plug 'vim-airline/vim-airline'" ~/.config/nvim/vim-plug/plugins.vim

sed -i "21 i \ \ \ \ Plug 'vim-airline/vim-airline-themes'" ~/.config/nvim/vim-plug/plugins.vim

cp airline.vim ~/.config/nvim/themes/

echo "source $HOME/.config/nvim/themes/airline.vim" >> ~/.config/nvim/init.vim

#Install all the things above
echo -e "Neovim will open in 10 seconds, when there type ':PlugStatus', it should print that plugins\n\
aren't installed, to install them type ':PlugInstall'"

sleep 10

nvim
