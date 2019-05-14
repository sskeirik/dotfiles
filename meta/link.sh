#!/bin/bash

# if we are not ZSH, assume BASH
if [ -z "$ZSH_VERSION" ]; then
  ln -s $HOME/.config/shell/shellrc  $HOME/.bashrc
  ln -s $HOME/.config/shell/inputrc  $HOME/.inputrc
  ln -s $HOME/.config/shell/profile  $HOME/.bash_profile
# otherwise, ZSH
else
  ln -s $HOME/.config/shell/shellrc  $HOME/.zshrc
  ln -s $HOME/.config/shell/profile  $HOME/.zprofile
fi

# if full Linux installation is requested
if [ "$1" = "full" ]; then
  ln -s $HOME/.config/sound/default-asoundrc $HOME/.asoundrc
  ln -s $HOME/.config/display/xinitrc        $HOME/.xinitrc
  echo "For High-DPI screens, please make sure browsers are scaled properly"
  echo "For chromium: check config/display/chromium-flags.conf"
  echo "For firefox: do online search"
else
  echo "Console installations will not link graphics/sound config files"
  echo "For full installation, re-run with as:"
  echo "$ link.sh full"
fi
