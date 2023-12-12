#!/bin/bash
set -euox pipefail

# define packages to be installed
PKGS=(                    \
  autoconf                \
  bison                   \
  flex                    \
  libbdd-dev              \
  libcln-dev              \
  libcvc4-dev             \
  libgmp-dev              \
  libsigsegv-dev          \
  libtecla-dev            \
  make                    \
)

# run non-interactive, minimal installation
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get --no-install-recommends --assume-yes install "${PKGS[@]}"
unset DEBIAN_FRONTEND
