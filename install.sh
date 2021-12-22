#!/bin/bash

sudo apt update
sudo apt upgrade -y

echo "Installing apt packages";

sudo apt install -y git vim curl

if ! hash google-chrome-stable 2>/dev/null; then
  echo "Installing google-chrome"
  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo apt update && sudo apt install google-chrome-stable -y
else
  echo "chrome already installed";
fi

if ! hash spotify 2>/dev/null; then
  echo "Installing spotify"
  curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
  sudo sh -c 'echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list'
  sudo apt update && sudo apt install spotify-client -y
else
  echo "spotify already installed";
fi

if ! hash telegram-desktop 2>/dev/null; then
  echo "Installing telegram-desktop"
  wget -O- https://telegram.org/dl/desktop/linux | sudo tar xJ -C /opt/
  sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram-desktop
else
  echo "telegram-desktop already installed"
fi

if ! hash code 2>/dev/null; then
  echo "Installing code"
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  sudo apt install apt-transport-https
  sudo apt update && sudo apt install code
else
  echo "code already installed"
fi

echo "Installing github packages"

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
