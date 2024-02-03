#!/usr/bin/env bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/zanqiliang/.zprofile 

eval "$(/opt/homebrew/bin/brew shellenv)"

brew install git

brew install fish

git config --global user.email "zanqi.liang@gmail.com"

git config --global user.name "Zanqi"

# fish
# fish_add_path /opt/homebrew/bin

brew install pyenv
# avoid a bug from brew version of python: https://stackoverflow.com/a/69517932/2382600
brew install xz

# set -Ux PYENV_ROOT $HOME/.pyenv

# fish_add_path $PYENV_ROOT/bin

# close and restart fish

pyenv install 3.11.5
pyenv global 3.11.5

# Now, add this to ~/.config/fish/config.fish:
# pyenv init - | source

# Optional
# brew install pyenv-virtualenv
# pyenv virtualenv 3.11.5 cs224u

# echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
# echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc

# echo 'eval "$(pyenv init -)"' >> ~/.zshrc

brew install mackup
git clone https://github.com/zanqi/dotfiles.git

cp dotfiles/.mackup.cfg ~/
mkdir /.mackup && cp dotfiles/.mackup/my-files.cfg "$_"


mackup restore --force && mackup uninstall --force

defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 13 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
