#!/usr/bin/env bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/zanqiliang/.zprofile 

eval "$(/opt/homebrew/bin/brew shellenv)"

brew install git
brew install tmux
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

# miniconda
brew install --cask miniconda

# Detect miniconda path
CONDA_BASE_PATH="$(brew --prefix)/Caskroom/miniconda/base"
if [ -d "$CONDA_BASE_PATH" ]; then
    # We need to source it to use the 'conda' command within this script
    export PATH="$CONDA_BASE_PATH/bin:$PATH"
    
    # 1. Skip the "conda init" nag by doing it now for all shells
    "$CONDA_BASE_PATH/bin/conda" init bash
    "$CONDA_BASE_PATH/bin/conda" init zsh
    "$CONDA_BASE_PATH/bin/conda" init fish

    # 2. Avoid the "Anaconda Terms of Service" prompt by preferring conda-forge
    # and setting up the channels immediately.
    "$CONDA_BASE_PATH/bin/conda" config --add channels conda-forge
    "$CONDA_BASE_PATH/bin/conda" config --set channel_priority strict
    
    # 3. Disable noisy "news" and "outdated" prompts
    "$CONDA_BASE_PATH/bin/conda" config --set notify_outdated_conda false
    "$CONDA_BASE_PATH/bin/conda" config --set anniversary_check false
    
    # 4. Ensure base is auto-activated so 'python' works out of the box
    "$CONDA_BASE_PATH/bin/conda" config --set auto_activate_base true
    
    # Install Python 3.14 in base environment
    "$CONDA_BASE_PATH/bin/conda" install -n base python=3.14 -y
fi

# avoid a bug from brew version of python: https://stackoverflow.com/a/69517932/2382600
brew install xz
brew install node

npm install -g @google/gemini-cli

# Update pip using the conda python
python -m pip install --upgrade pip

brew install mackup
git clone https://github.com/zanqi/dotfiles.git

cp dotfiles/Mackup/.mackup.cfg ~/
mkdir ~/.mackup && cp dotfiles/Mackup/.mackup/my-files.cfg "$_"


mackup restore --force && mackup --force link uninstall

# Re-run init after mackup restore just in case restore overwrote the shell configs
if [ -d "$CONDA_BASE_PATH" ]; then
    "$CONDA_BASE_PATH/bin/conda" init bash
    "$CONDA_BASE_PATH/bin/conda" init zsh
    "$CONDA_BASE_PATH/bin/conda" init fish
fi

defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 13
defaults write -g KeyRepeat -int 1

# fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
# fish -c "fisher install IlanCosman/tide@v6"

which bash | sudo tee -a /etc/shells
which bash | xargs chsh -s
