#!/bin/sh
if [ $# -lt 1 ]; then
    echo "Bundle URL? \c"
    read url
else
    url="$1"
fi
git submodule add --force "$url" bundle/$(basename "$url" | sed 's/\.git$//')
