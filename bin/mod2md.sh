#!/usr/bin/env bash -
#===============================================================================
#
#          FILE: mod2md.sh
# 
#         USAGE: ./mod2md.sh 
# 
#   DESCRIPTION: Generate markdown for submodules
# 
#===============================================================================

awk '/path|url/ {print $3}' ../.gitmodules | sed 's/bundle\//\n/' | awk 'BEGIN { RS="" } {print "* ["$1"]("$2")"}'
