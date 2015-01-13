#!/usr/bin/env bash
#===============================================================================
#
#          FILE: mod2md.sh
#
#         USAGE: ./mod2md.sh
#
#   DESCRIPTION: Generate markdown for submodules
#
#===============================================================================

set -e

if [ -f "$PWD/.gitmodules" ]; then
    _gitmodules="$PWD/.gitmodules"
elif [ -f $PWD/../.gitmodules ]; then
    _gitmodules="$PWD/../.gitmodules"
else
    echo "Fail to read file '.gitmodules'"
    exit 1
fi
awk '/path|url/ {print $3}' $_gitmodules \
    | sed 's/bundle\//\n/' \
    | awk 'BEGIN { RS="" } {print "* ["$1"]("$2")"}'
echo ""
