#!/bin/bash
cd ~/Downloads/nvim
tt nvim.appimage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
cd ~
