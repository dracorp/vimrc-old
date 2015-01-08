#!/usr/bin/env bash
#===============================================================================
#
#          FILE: rm-bundle.sh
#
#         USAGE: ./rm-bundle.sh directory
#
#   DESCRIPTION: Generate markdown for submodules
#
#===============================================================================
set -e

if [[ ! -d "bundle" ]]; then
    echo "You must inside directory vim of user"
    exit 1
fi

if [ $# -lt 1 ]; then
    echo "Choices are:"
    ls bundle
    echo
    echo "Bundle name? \c"
    read name
else
    name="$1"
fi

name=$(basename "$name")
path="bundle/${name%/}"
rm -rf "$path"
git submodule deinit --force "$path"
git rm -rf "$path"
