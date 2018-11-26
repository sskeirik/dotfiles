#!/bin/bash
# this build script copied from the arch linux package
./configure "$@" \
            --with-shared --with-normal --without-debug --without-ada \
            --enable-widec --enable-pc-files --with-cxx-binding --with-cxx-shared \
            --with-manpage-format=normal \
	    --with-pkg-config-libdir="$HOME/.local/build/local/lib/pkgconfig"
