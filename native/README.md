# Native Linux Configuration

This folder contains configuration files needed for "native" linux
configurations, i.e., bare metal, non-headless configurations which need
audio/video/input/quirks support.

## Audio

Included files:

-   asoundrc files which help configure the linux audio environment ALSA

## Video

Currently, we don't provide any video configuration files.
In the future, we may provide X11/Xorg configuration files/scripts.

## Input

Currently, we don't provide any input configuration files.
In the future, we may provide libinput based configuration files/scripts.

## Quirks

Sometimes, program-specific configuration files are needed, especially for more
complex applications like web browsers.
We list included program-specific configuration files/scripts here.

-   chromium flags for HiDPI screens
