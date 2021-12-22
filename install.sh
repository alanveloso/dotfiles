#!/bin/bash

sudo apt update
sudo apt upgrade -y

echo "Installing apt packages";

sudo apt install -y git vim curl

if ! hash google-chrome-stable 2>/dev/null; then
  echo "Installing google-chrome"
  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo apt update
  sudo apt install google-chrome-stable
else
  echo "chrome already installed";
fi

if ! hash spotify 2>/dev/null; then
  echo "Installing spotify"
  curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
  sudo sh -c 'echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list'
  sudo apt update
  sudo apt install spotify-client
else
  echo "spotify already installed";
fi

if ! hash telegram-desktop 2>/dev/null; then
  wget -O- https://telegram.org/dl/desktop/linux | sudo tar xJ -C /opt/
  sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram-desktop
else
  echo "telegram-desktop already installed"

echo "Installing github packages"

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
