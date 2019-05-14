#!/bin/bash

# if we are not ZSH, assume BASH
if [ -z "$ZSH_VERSION" ]; then
  ln -s $HOME/.config/shell/shellrc  $HOME/.bashrc
  ln -s $HOME/.config/bash/inputrc   $HOME/.inputrc
# otherwise, ZSH
else
  ln -s $HOME/.config/shell/shellrc  $HOME/.zshrc
fi

# if full Linux installation is requested
if [ "$1" = "full" ]; then
  ln -s $HOME/.config/sound/default-asoundrc $HOME/.asoundrc
else
  echo "Console installations will not link graphics/sound config files"
  echo "For full installation, re-run with as:"
  echo "$ link.sh full"
fi
