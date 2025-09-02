#!/bin/bash

absolute_path() (
  cd "$(dirname "$1")" && pwd -P 
)
SCRIPTPATH="$(absolute_path "$0")"

set -eu
set -o pipefail

#MYTMPDIR="$(mktemp -d)"
#trap 'rm -rf -- "$MYTMPDIR"' EXIT
