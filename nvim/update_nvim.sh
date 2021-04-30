#!/bin/bash
cd ~/Downloads/nvim
rm nvim.appimage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage
cd ~
