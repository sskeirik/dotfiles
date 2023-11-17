#!/bin/bash
set -euo pipefail

NEOVIM_PPA=neovim-ppa/unstable

# define packages to be installed
PKGS=(                                         \
  build-essential                              \
  gpg-agent software-properties-common         \
  sudo                                         \
  docker.io                                    \
  python3-dev python3-pip python3-venv         \
  curl wget openssl ca-certificates            \
  git                                          \
  ssh                                          \
  unzip                                        \
  zsh file htop tree ripgrep fd-find direnv    \
)
# define extras to be installed
EXTRAS=(         \
  setup-man      \
  neovim         \
  rename-fd-find \
)

function update() {
  DEBIAN_FRONTEND=noninteractive apt-get update --quiet
}
function install() {
  DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends --yes --quiet "$@"
}
function reinstall() {
  DEBIAN_FRONTEND=noninteractive apt-get reinstall --no-install-recommends --yes --quiet "$@"
}

if [ $EUID -ne 0 ]; then
  echo -e "Please run as root"
  exit 1
fi

# echo commands to be performed
set -x

# install manpages
sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' /etc/dpkg/dpkg.cfg.d/excludes
update
install             \
  man               \
  manpages          \
  manpages-dev      \
  manpages-posix    \
  manpages-posix-dev

# finish installing man
rm -f /usr/bin/man
dpkg-divert --quiet --remove --rename /usr/bin/man
rm -f /usr/share/man/man1/sh.1.gz
dpkg-divert --quiet --remove --rename /usr/share/man/man1/sh.1.gz

# setup apt basics
install apt-utils dialog

# reinstall apt to get manpage
reinstall apt

# setup timezone and locale
ln -s /usr/share/zoneinfo/America/New_York /etc/localtime
install locales
sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

# run non-interactive, minimal installation
install "${PKGS[@]}"
( add-apt-repository -L | rg "$NEOVIM_PPA" ) || { add-apt-repository --yes ppa:"$NEOVIM_PPA" ; update }
install neovim
ln -s $(which fdfind) ~/.local/bin/fd
unset DEBIAN_FRONTEND
