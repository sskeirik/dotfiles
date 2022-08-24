# Intro

If you're looking for yet-another-dotfile repo, you've come to the right place!
My current development environment uses the following components:

- Windows Subsystem for Linux
- wsltty (mintty + wslbridge)
- tmux
- neovim (plugins managed by pathogen)
- lightweight git aliases
- zshell + lightweight async git status prompt

See section [Fresh Installation](#fresh-installation) for information about quickly getting a new system up-to-speed.

# Tour

The most interesting bits to others would probably be:

1. My tmux config files
2. My shell config files
3. My dircolors config files

## Tmux

I have a keybinding `alt + shift + I` which I use to force tmux into an *ignore*
mode. In this mode, tmux will directly pass-through all keystrokes to the underlying
program except for `alt + shift + I` which undoes ignore mode.

This is useful for nested tmux sessions, because:

1. It allows the user to switch back and forth between local and remote tmux sessions in a single keypress.
2. It allows the user to work in a nested tmux session without typing the prefix-key twice every time a tmux-command
   is used remotely.

I highly recommend the plugin `tmux-onedark-theme` which looks amazing, IMO. 

## Shell

Underneath the `/shell` directory I have a unified shell init file `shellrc` for bash and zsh usage.
I configure terminal colors using the `base16-shell` repo and associated shell scripts;
the great thing is that this solution does not depend on `Xresources` or any other non-shell config file.
As long as your terminal supports changing colors by escape codes, this method will work.

Previously, I used a minimalist git prompt I found and modified from a blog online, but because it lagged on large repos,
I recently switched to `powerlevel10k` with `purepower` configured as my prompt because the `git status` is asynchronous.

## Dircolors

Honestly, dircolors configuration is somewhat arcane.
I had to dig for quite awhile to understand how it works now (and it used to work).
The frustration is excaberated by WSL, because of wonky permission mappings when accessing the windows filesystem
from linux, so that most standard dircolors choices look quite bad.

To rememdy this, I collected a bunch of color scripts I found online and modified a test script I
found so that I could compare various choices. This script can be found under `dircolors/test`.

## Fresh Installation

### Installing a WSL Distribution

If installing a new WSL distribution, my recommended approach is to use [LxRunOffline](https://github.com/DDoSolitary/LxRunOffline).
To use LxRunOffline, first download the tool.
Then, in an elevated Windows command prompt, run the following steps:

1.  Install the distribution

    ```cmd
    LxRunOffline.exe i -n <distro_name> -d <distro_filesystem_directory> -f <distro_filesystem_tarball>
    ```

2.  Use `wsl` to set the version

    ```cmd
    wsl.exe --set-version <distro_name> 2
    ```

3.  Finally, once the system has been configured with a proper user, do:

    ```cmd
    LxRunOffline.exe su -n <distro_name> -v <uid>
    ```

    Note: `<uid>` is almost always `1000`.

### Post-Installation Steps

When installing on a fresh system, there are a couple post-installation steps:

1.  After cloning, this repository should be moved to `$HOME/.config`
2.  After cloning, run `git submodule update --init --recursive` to grab all submodules
3.  Check the `meta/install` directory for both:

    -   distribution specific install scripts
    -   the `link` script which setups symlinks in `$HOME` for various configuration files
