#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting macOS setup..."

# 1. Install Homebrew (if not already installed)
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Initialize Homebrew for the current script session
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add Homebrew to your bash profile (since you switch to bash at the end) and zprofile (macOS default)
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile

# 2. Batch Install Homebrew Packages (Much faster)
echo "Installing brew packages..."
brew install \
    git tmux fish zoxide fzf tldr bat eza \
    ripgrep gh lazydocker bash wget stats \
    btop xz node mackup

# 3. Batch Install Casks (Includes Java 21 upgrade)
echo "Installing brew casks..."
brew install --cask \
    iterm2 visual-studio-code google-chrome vlc \
    qbittorrent wechat rectangle google-drive \
    grammarly-desktop obsidian notion docker \
    temurin@21 miniconda

# 4. Unattended FZF setup
echo "Setting up fzf..."
$(brew --prefix)/opt/fzf/install --all

# 5. Git Configuration
echo "Configuring Git..."
git config --global user.email "zanqi.liang@gmail.com"
git config --global user.name "Zanqi"
git config --global push.default simple

# 6. Miniconda Setup
echo "Configuring Miniconda..."
CONDA_BASE_PATH="$(brew --prefix)/Caskroom/miniconda/base"

if [ -d "$CONDA_BASE_PATH" ]; then
    # Properly source conda for this script session
    source "$CONDA_BASE_PATH/etc/profile.d/conda.sh"
    
    # Init for shells
    conda init bash zsh fish

    # Explicitly accept the Anaconda Terms of Service
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

    # Suppress update warnings and handle auto-activation quietly
    conda config --set notify_outdated_conda false
    conda config --set auto_activate true
    
    # Update pip safely using the absolute path to Conda's base Python
    "$CONDA_BASE_PATH/bin/python" -m pip install --upgrade pip
fi

# 7. Global NPM Packages
echo "Installing NPM packages..."
npm install -g @google/gemini-cli

# 8. Mackup and Dotfiles
echo "Setting up dotfiles..."
# Ensure the parent directory exists, clone if dotfiles isn't already there
if [ ! -d "dotfiles" ]; then
    git clone https://github.com/zanqi/dotfiles.git
fi

cp dotfiles/Mackup/.mackup.cfg ~/
mkdir -p ~/.mackup 
cp dotfiles/Mackup/.mackup/my-files.cfg ~/.mackup/

echo "Restoring Mackup..."
mackup restore --force && mackup --force link uninstall

# Re-run conda init just in case mackup overwrote the shell configs
# if [ -d "$CONDA_BASE_PATH" ]; then
#    conda init bash zsh fish
# fi

# 9. macOS Defaults
echo "Setting macOS defaults..."
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 13
defaults write -g KeyRepeat -int 1

# 10. Set Default Shell to Bash
echo "Changing default shell to Bash..."
# We only append to /etc/shells if it's not already there
BREW_BASH="$(brew --prefix)/bin/bash"
if ! grep -q "$BREW_BASH" /etc/shells; then
    echo "$BREW_BASH" | sudo tee -a /etc/shells
fi
chsh -s "$BREW_BASH" "$USER"

echo "✅ Setup complete! Please restart your terminal (or your Mac) for all changes to take effect."
