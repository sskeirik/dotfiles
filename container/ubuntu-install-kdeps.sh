#!/bin/bash
set -euox pipefail

# define packages to be installed
PKGS=(                    \
  bison                   \
  build-essential         \
  cmake                   \
  curl                    \
  flex                    \
  g++                     \
  gcc                     \
  libboost-test-dev       \
  libfmt-dev              \
  libgmp-dev              \
  libjemalloc-dev         \
  libmpfr-dev             \
  libsecp256k1-dev        \
  libyaml-dev             \
  libz3-dev               \
  clang-15                \
  lld-15                  \
  llvm-15-tools           \
  m4                      \
  maven                   \
  openjdk-17-jdk-headless \
  pkg-config              \
  z3                      \
  zlib1g-dev
)

# run non-interactive, minimal installation
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get --no-install-recommends --assume-yes install "${PKGS[@]}"
unset DEBIAN_FRONTEND
