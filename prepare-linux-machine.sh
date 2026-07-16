#!/bin/bash

# Prepare Linux machine for development environment setup
set -euo pipefail

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or use sudo"
    exit 1
fi

# Check package manager
if command -v apt-get &> /dev/null; then
    PACKAGE_MANAGER="apt-get"
elif command -v yum &> /dev/null; then
    PACKAGE_MANAGER="yum"
elif command -v dnf &> /dev/null; then
    PACKAGE_MANAGER="dnf"
else
    echo "Error: Supported package manager not found (apt-get, yum, or dnf)"
    exit 1
fi

# Update package repositories
echo "Updating package repositories..."
$PACKAGE_MANAGER update -y

# Install development tools
echo "Installing development tools..."
$PACKAGE_MANAGER install -y git curl wget vim

# Cleanup package cache
echo "Cleaning up package cache..."
$PACKAGE_MANAGER clean -y

echo "Development environment setup complete!"

# Install zsh
echo "Installing zsh..."
$PACKAGE_MANAGER install -y zsh

# Change default shell to zsh
echo "Changing default shell to zsh..."
chsh -s $(which zsh)

echo "zsh installation and configuration complete!"

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Oh My Zsh installation complete!"

# Install zsh plugins
echo "Installing zsh plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "zsh plugins installation complete!"

# Configure zsh plugins in .zshrc
echo "Configuring zsh plugins..."
sed -i '/^plugins=(/ s/\)/ zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc

echo "zsh configuration complete!"

# Reload zsh to apply changes
echo "Reloading zsh..."
exec zsh

# Install Zed
echo "Installing Zed editor..."
curl -f https://zed.dev/install.sh | sh

# Copy Zed configuration
echo "Copying Zed configuration..."
mkdir -p ~/.config/zed
cp -r zed/settings.json ~/.config/zed/settings.json

echo "Zed installation complete!"
