#!/usr/bin/env bash
#===============================================================================
#
#          FILE: add-vba-bundle.sh
#
#         USAGE: ./add-vba-bundle.sh [vimball.file.vba]
#
#   DESCRIPTION: Add vimball file to the bundle directory
#
#  REQUIREMENTS: vim
#===============================================================================

set -e

if [[ ! "$1" =~ \.vba$ || ! -d "bundle" ]]; then
    echo "Usage: $0 vimball.file.vba"
    echo "You must inside directory vim of user"
    exit 1
fi

module=$(basename $1 .vba)
if [ ! -d "bundle/$module" ]; then
    mkdir -p "bundle/$module"
fi

vim -c "UseVimball $(pwd)/bundle/$module" -c "q" "$1"
