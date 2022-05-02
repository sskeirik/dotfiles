#!/bin/bash

set -eu

readword () {
  read -p "$1 " -a reply
  [ ${#reply[@]} -ne 1 ] && echo "Response may not contain spaces" 1>&2 && exit 1
  echo ${reply[0]}
}

name=$(readword "Container name>")
image=$(readword "Docker image:tag>")

cmd="docker run --mount=type=bind,src=$HOME,dst=/host -it --name ${name[0]} ${image[0]}"

echo "About to run> $cmd"
resp=$(readword "Continue? [Y/n]")
[ -n $resp ] && ( [ $resp != Y ] && [ $resp != y ] ) && echo "Aborting..." && exit 0

# run cmd
$cmd
