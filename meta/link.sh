#!/bin/bash
# Config file installation script

# shell selection
if [ "$1" = "bash" ]; then
  echo "bash selected; installing bash links..."
  ln -s $HOME/.config/shell/shellrc  $HOME/.bashrc         2>/dev/null
  ln -s $HOME/.config/shell/inputrc  $HOME/.inputrc        2>/dev/null
  ln -s $HOME/.config/shell/profile  $HOME/.bash_profile   2>/dev/null
  mkdir -p $HOME/.local/bin                                &>/dev/null
  ln -s $HOME/.config/meta/ding      $HOME/.local/bin/ding 2>/dev/null
# otherwise, ZSH
elif [ "$1" = "zsh" ]; then
  echo "zsh selected, installing zsh links..."
  ln -s $HOME/.config/shell/shellrc  $HOME/.zshrc          2>/dev/null
  ln -s $HOME/.config/shell/profile  $HOME/.zprofile       2>/dev/null
  mkdir -p $HOME/.local/bin                                &>/dev/null
  ln -s $HOME/.config/meta/ding      $HOME/.local/bin/ding 2>/dev/null
else
  echo "usage: link.sh (bash|zsh) [full]"
  exit 1
fi

echo "" # separate output

# if full Linux installation is requested
if [ "$2" = "full" ]; then
  ln -s $HOME/.config/sound/default-asoundrc $HOME/.asoundrc 2>/dev/null
  ln -s $HOME/.config/display/xinitrc        $HOME/.xinitrc  2>/dev/null
  echo "For High-DPI screens, please make sure browsers are scaled properly"
  echo "For chromium: check config/display/chromium-flags.conf"
  echo "For firefox: do online search"
else
  echo "Console installations will not link graphics/sound config files"
  echo "For full installation, re-run with as:"
  echo "$ link.sh $1 full"
fi
