#!/bin/sh

function command_exists {
  type "$1" &> /dev/null
}

# Update brew and its casks
if command_exists brew; then
  brew update
  brew upgrade
  brew upgrade --cask --greedy
  brew cleanup -s && rm -rf $(brew --cache)
fi

# Update Oh-My-Zsh
OHMYZSH_UPDATE_SCRIPT="$ZSH/tools/upgrade.sh"
if [ -f "$OHMYZSH_UPDATE_SCRIPT" ]; then
  sh $OHMYZSH_UPDATE_SCRIPT
fi

# Update global npm packages
if command_exists npm; then
  npm update -g -f
fi

# Update python packages
if command_exists pip3; then
  pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U
fi

# Update macOS
sudo softwareupdate -i -a
