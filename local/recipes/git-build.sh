#!/bin/bash

DEST="$HOME/toolchain"
LIBDIR="$HOME/.config/local/build/local/lib"

make prefix="$DEST" \
     LDFLAGS="-L$LIBDIR" \
     CFLAGS="-static" \
     NO_EXPAT=YesPlease NO_TCLTK=YesPlease NO_GETTEXT=YesPlease NO_REGEX=NeedsStartEnd NO_PYTHON=YesPlease NO_SYS_POLL_H=YesPlease \
     NEEDS_SSL_WITH_CURL=YesPlease \
     NEEDS_CRYPTO_WITH_SSL=YesPlease \
     RUNTIME_PREFIX=YesPlease \
     PROCFS_EXECUTABLE_PATH="/proc/self/exe" \
     V=1 \
     all \
     install

