#!/bin/bash
set -euo pipefail

# this script should be run as a user

# setup barebones ssh config for use with git
SSH_DIR=$HOME/.ssh
SSH_FILE="$SSH_DIR/config"
if [ ! -f "$SSH_FILE" ]; then
  mkdir "$SSH_DIR" &>/dev/null || true
  chmod 700 "$SSH_DIR"
  echo "AddKeysToAgent yes" > "$SSH_FILE"
  chmod 600 "$SSH_FILE"
fi
