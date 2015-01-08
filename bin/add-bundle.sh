#!/usr/bin/env bash
#===============================================================================
#
#          FILE: add-bundle.sh
#
#         USAGE: ./add-bundle.sh URL
#
#   DESCRIPTION: Add a new plugin as submodule
#
#===============================================================================
set  -e

if [ $# -lt 1 ]; then
    echo "Bundle URL? \c"
    read url
else
    url="$1"
fi
git submodule add --force "$url" bundle/$(basename "$url" | sed 's/\.git$//')
