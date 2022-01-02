# Arch Linux configuration

`Neovim`
- mkdir ~/.config/nvim
- touch ~/.config/nvim/init.vim
- curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
- mkdir ~/.config/nvim/vim-plug
- touch ~/.config/nvim/vim-plug/plugins.vim
- mkdir ~/.config/nvim/general
- touch ~/.config/nvim/general/settings.vim
- copy `settings.vim` file to ~/.config/nvim/general
- source $HOME/.config/nvim/general/settings.vim
- mkdir ~/.config/nvim/keys
- touch ~/.config/nvim/keys/mappings.vim
- copy `mappings.vim` file to ~/.config/nvim/keys
- source $HOME/.config/nvim/keys/mappings.vim
- go to Neovim and type `:checkhealth`
