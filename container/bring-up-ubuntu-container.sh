#!/bin/bash
# bring-up-ubuntu-container.sh
set -euo pipefail

USERS=$(cat /etc/passwd | grep -vE "nologin|false" | cut -f1 -d:)
ME=stephen
PKGS=(                                         \
  python3-dev python3-pip python3-venv         \
  curl wget openssl ca-certificates            \
  git                                          \
  sudo                                         \
  man-db                                       \
  gpg-agent software-properties-common         \
  ssh                                          \
)

# create user if needed
if grep -E "^$ME\$" &>/dev/null <<< $USERS; then
  echo "User '$ME' exists. Continuing..."
else
  echo "User '$ME' does not exist. Creating..."

  # set passwd
  read -p "Enter your password: " -s pw
  echo
  read -p "Enter your password again: " -s pw2
  [[ "$pw" != "$pw2" ]] && echo "Passwords do not match" && exit 1

  # create user and set passwds
  useradd -m -G sudo -s /bin/bash "$ME"
  echo -e "$pw\n$pw" | passwd "$ME" &>/dev/null
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
unset DEBIAN_FRONTEND

# install non-packaged binaries

# install non-packaged binaries as user
su - "$ME" << EOF
curl https://sh.rustup.rs -sSf | sh -s -- -y
EOF
