#!/bin/bash
# bring-up-ubuntu-container.sh

ME=stephen

# set passwd
read -p "Enter your password: " -s pw
echo
read -p "Enter your password again: " -s pw2
[[ "$pw" != "$pw2" ]] && echo "Passwords do not match" && exit 1

packages=(                                     \
  python3 python3-dev python3-pip python3-venv \
  npm                                          \
  opam                                         \
  curl wget openssl ca-certificates            \
  libsecp256k1-dev libsodium-dev               \
  git                                          \
  sudo                                         \
  man-db                                       \
  neovim                                       \
)

# unminimize system to get man-db
# echo -e "Y\nY\n" | unminimize

# remove man pages from excluded files
sed -i 's@^path-exclude=/usr/share/man/@#path-exclude=/usr/share/man/@' /etc/dpkg/dpkg.cfg.d/excludes

# run non-interactive, minimal installation
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get --no-install-recommends --assume-yes install ${packages[@]}
unset DEBIAN_FRONTEND

# create user and set passwds
echo -e "$pw\n$pw" | passwd
useradd -m -G sudo -s /bin/bash "$ME"
echo -e "$pw\n$pw" | passwd "$ME"

# install non-packaged binaries

# install non-packaged binaries as user
su - stephen << EOF
curl https://sh.rustup.rs -sSf | sh -s -- -y
EOF
