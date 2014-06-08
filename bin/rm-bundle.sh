#!/bin/sh
set -e

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
