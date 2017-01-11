sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y autoremove

if ! hash git 2>/dev/null; then
	sudo apt-get -y install git
else
	echo "git already installed";
fi

if ! hash vim 2>/dev/null; then
	sudo apt-get -y install vim
else
	echo "vim already installed";
fi

if ! hash tmux 2>/dev/null; then
	sudo apt-get -y install tmux
else
	echo "tmux already installed";
fi

if ! hash g++ 2>/dev/null; then
	sudo apt-get -y install g++
else
	echo "g++ already installed"
fi

if ! hash spotify 2>/dev/null; then
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update
	sudo apt-get install spotify-client
else
	echo "spotify already installed";
fi

if ! hash stow 2>/dev/null; then
	sudo apt-get -y install stow
else
	echo "stow already installed";
fi

stow git
stow vim
