if ! hash stow 2>/dev/null; then
	sudo apt-get install stow
else
	echo "stow já instalado";
fi

stow git
stow vim
