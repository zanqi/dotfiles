#!/usr/bin/env bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/zanqiliang/.zprofile 

eval "$(/opt/homebrew/bin/brew shellenv)"

brew install git
brew install fish
brew install zoxide
brew install fzf
$(brew --prefix)/opt/fzf/install



brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask google-chrome
brew install --cask vlc
brew install --cask qbittorrent
brew install --cask wechat
brew install --cask rectangle
brew install --cask google-drive
brew install --cask grammarly-desktop
brew install --cask obsidian
brew install --cask notion
brew install tldr
brew install bat
brew install eza
brew install ripgrep
brew install gh
brew install --cask docker
brew install lazydocker
brew install --cask temurin@17
brew install bash
brew install wget
brew install --cask stats
brew install btop

git config --global user.email "zanqi.liang@gmail.com"
git config --global user.name "Zanqi"
git config --global push.default simple

# fish
# fish_add_path /opt/homebrew/bin

brew install pyenv
# avoid a bug from brew version of python: https://stackoverflow.com/a/69517932/2382600
brew install xz

pyenv install 3.12.11
pyenv global 3.12.11
pip install --upgrade pip
pip install numpy scipy matplotlib jupyterlab panda seaborn plotly
pip install 'markitdown[all]'

# Optional
# brew install pyenv-virtualenv
# pyenv virtualenv 3.11.5 cs224u

# echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
# echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc

# echo 'eval "$(pyenv init -)"' >> ~/.zshrc
brew install mackup
git clone https://github.com/zanqi/dotfiles.git

cp dotfiles/Mackup/.mackup.cfg ~/
mkdir /.mackup && cp dotfiles/Mackup/.mackup/my-files.cfg "$_"


mackup restore --force && mackup --force link uninstall

defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 13
defaults write -g KeyRepeat -int 1

# fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
# fish -c "fisher install IlanCosman/tide@v6"

which bash | sudo tee -a /etc/shells
which bash | xargs chsh -s
