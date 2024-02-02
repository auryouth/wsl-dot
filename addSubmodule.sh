#!/bin/bash

git init
git submodule add https://github.com/seebi/dircolors-solarized shell/plugins/dircolors-solarized
git submodule add https://github.com/zsh-users/zsh-syntax-highlighting shell/plugins/zsh-syntax-highlighting
git submodule add https://github.com/zsh-users/zsh-completions shell/plugins/zsh-completions
git submodule add https://github.com/zsh-users/zsh-autosuggestions shell/plugins/zsh-autosuggestions
git submodule add git@github.com:auryouth/nvim.git
git submodule add https://github.com/anishathalye/dotbot
git config -f .gitmodules submodule.dotbot.ignore dirty
cp dotbot/tools/git-submodule/install .
