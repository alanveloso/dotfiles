#!/bin/bash

sudo apt update
sudo apt upgrade -y

if ! hash google-chrome-stable 2>/dev/null; then
  echo "Adding chrome source list"
  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo apt update
else
  echo "chrome already installed";
fi

echo "Installing apt packages";

sudo apt install -y git vim snapd google-chrome-stable telegram-desktop

echo "Installing snap packages"

sudo snap install spotify
sudo snap install --classic code

echo "Installing github packages"

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
