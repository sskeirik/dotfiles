#!/bin/bash
set -euo pipefail

echo "This script will create a new admin user"
USERS=$(cat /etc/passwd | grep -vE "nologin|false" | cut -f1 -d:)
read -p "Select your username: " ME

# create user if needed
if grep -E "^$ME\$" &>/dev/null <<< $USERS; then
  echo "User '$ME' exists. Exiting..."
else
  echo "User '$ME' does not exist. Creating..."

  # set passwd
  read -p "Enter your password: " -s pw
  echo
  read -p "Enter your password again: " -s pw2
  [[ "$pw" != "$pw2" ]] && echo "Passwords do not match" && exit 1

  # create user in sudo group, set shell, and add passwds
  useradd -m -G sudo -s /bin/bash "$ME"
  echo -e "$pw\n$pw" | passwd "$ME" &>/dev/null
  echo "Successfully created user $ME"
fi
