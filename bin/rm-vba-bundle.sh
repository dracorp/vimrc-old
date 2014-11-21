#!/bin/bash -
#===============================================================================
#
#          FILE: rm-vba-bundle.sh
#
#         USAGE: ./rm-vba-bundle.sh [directory with submodule]
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: vim
#===============================================================================

if [[ ! -d "bundle" ]]; then
    echo "You must inside directory vim of user"
    exit 1
fi

module=$(basename $1)
fulldirectory="$(pwd)/bundle/$module"
if [ ! -d "$fulldirectory" ]; then
    echo "Directory '$module' not found in bundle directory"
    exit 1
fi

read -p "Removing '$fulldirectory' directory. Are you sure? [Ny]" answer
if [[ "$answer" =~ [yY] ]]; then
    rm -rfv "$fulldirectory"
fi
