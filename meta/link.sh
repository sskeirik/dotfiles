#!/bin/bash

# if we are not ZSH, assume BASH
if [ -z "$ZSH_VERSION" ]; then
  ln -s $HOME/.config/shell/shellrc  $HOME/.bashrc
  ln -s $HOME/.config/bash/inputrc   $HOME/.inputrc
# otherwise, ZSH
else
  ln -s $HOME/.config/shell/shellrc  $HOME/.zshrc
fi
