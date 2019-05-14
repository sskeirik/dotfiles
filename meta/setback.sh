#!/bin/bash

NAME='.background.png'
OUTPUT="$HOME/$NAME"
DEFAULT_DIR="$HOME/Downloads"
EXTLIST="png jpg jpeg"

function usage() {
  echo 'usage: setback [imagefile|directory]'
  echo "       if passed imagefile: convert to png, copy to '\$HOME/$NAME', and set as background"
  echo "       if passed directory: use most recent image in directory as imagefile"
  echo
  echo '       requires "file"    to check that <imagefile> is valid'
  echo '       requires "convert" to convert <imagefile> to png if needed'
  echo '       requires "feh"     to set background'
  exit $1
}

([ ! $(command -v file) ] || [ ! $(command -v convert) ] || [ ! $(command -v feh) ]) && usage 1

if [ -f "$1" ]; then
  INPUT="$1"
elif [ -d "$1" ]; then
  echo "setting '$OUTPUT' to most recent image in '$1'"
  for filename in $(ls -t "$1")
  do
    file="$1/$filename"
    EXT="$(file -b --extension "$file")"
    EXT="${EXT%%/*}"
    if [[ "$EXTLIST" == *"$EXT"* ]]; then
      INPUT="$file"
      break
    fi
  done
else
  usage 1
fi

[ -f "$INPUT" ] || usage 1

echo "setting '$OUTPUT' to '$INPUT'"
convert "$INPUT" "$OUTPUT"
echo "setting background to '$OUTPUT'"
feh --bg-fill "$OUTPUT"
