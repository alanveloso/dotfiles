#!/bin/bash

set -euo pipefail

cd $HOME

if [ -d .dot ]; then
  echo "Already installed dotfiles"
  exit 1
fi

if ! command -v git &>/dev/null; then
  sudo apt install -y git
fi

git clone --bare https://github.com/alanveloso/dotfiles.git $HOME/.dot || { echo "Erro ao clonar repositório bare." >&2; exit 1; }

function dot {
  git --git-dir=$HOME/.dot/ --work-tree=$HOME "$@"
}

mkdir -p .dot-backup

dot checkout || true

if [ $? = 0 ]; then
  echo "Checked out dot."
else
  echo "Backing up pre-existing dot files."

  rm -rf .dot-backup
  for file in $(dot checkout 2>&1 | egrep "^\s+" | awk {'print $1'})
  do
    mkdir -p $(dirname .dot-backup/$file)
    echo "Backup $file => .dot-backup/$file"
    mv $file .dot-backup/$file
  done
  dot checkout || { echo "Erro ao aplicar dotfiles." >&2; exit 1; }
fi;

dot reset HEAD . > /dev/null

# Garantir que checkout foi bem-sucedido
if ! dot checkout . > /dev/null; then
  echo "Erro ao restaurar arquivos do dotfiles." >&2
  exit 1
fi

dot config status.showUntrackedFiles no

echo "Dotfiles installed"

. install.sh || { echo "Erro ao rodar install.sh." >&2; exit 1; }

if [ -f .bashrc ]; then
  source .bashrc
fi
