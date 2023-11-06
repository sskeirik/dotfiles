#!/bin/bash
set -euo pipefail

# define packages to be installed
PKGS=(                                         \
  gpg-agent software-properties-common         \
  sudo                                         \
  man-db                                       \
  python3-dev python3-pip python3-venv         \
  curl wget openssl ca-certificates            \
  git                                          \
  ssh                                          \
  unzip                                        \
  htop tree ripgrep fd-find                    \
)
# define extras to be installed
EXTRAS=(         \
  neovim         \
  rename-fd-find \
)

if [ $EUID -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

# echo commands to be performed
set -x

# remove man pages from excluded files
sed -i 's@^path-exclude=/usr/share/man/@#path-exclude=/usr/share/man/@' /etc/dpkg/dpkg.cfg.d/excludes

# run non-interactive, minimal installation
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get --no-install-recommends --assume-yes install "${PKGS[@]}"
add-apt-repository --yes ppa:neovim-ppa/stable
apt-get update
apt-get --no-install-recommends --assume-yes install neovim
ln -s $(which fdfind) ~/.local/bin/fd
unset DEBIAN_FRONTEND
