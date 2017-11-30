#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `osxprep.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Step 1: Update the OS and Install Xcode Tools
echo "------------------------------"
echo "Updating OSX.  If this requires a restart, run the script again."
# Install all available updates
sudo softwareupdate -iva
# Install only recommended available updates
#sudo softwareupdate -irv

echo "------------------------------"
echo "Installing Xcode Command Line Tools."
# Install Xcode command line tools
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install Cask
brew tap caskroom/cask
brew tap caskroom/versions

# Core casks
brew cask install java8
brew install maven

# Development tool casks
brew cask install --appdir="/Applications" sublime-text
brew cask install --appdir="/Applications" visual-studio-code
brew cask install --appdir="/Applications" virtualbox
brew cask install --appdir="/Applications" vagrant
brew cask install --appdir="/Applications" macdown
#brew cask install --appdir="~/Applications" Caskroom/versions/intellij-idea-ce

# Misc casks
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" firefox
#brew cask install --appdir="/Applications" skype
brew cask install --appdir="/Applications" slack
#brew cask install --appdir="/Applications" dropbox
#brew cask install --appdir="/Applications" google-drive

# Install Docker, which requires virtualbox
brew install docker
brew install boot2docker

# Install data stores
brew install mysql
brew install postgresql

# Creates a new PostgreSQL database defaulted to current system user
createdb

# Install mysql workbench
# brew cask install --appdir="/Applications" mysqlworkbench

# Install Node
brew install node

# Remove outdated versions from the cellar.
brew cleanup

# Install Web tools
npm install -g @angular/cli
