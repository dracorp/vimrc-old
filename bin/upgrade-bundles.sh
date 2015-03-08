#!/usr/bin/env bash
#===============================================================================
#
#          FILE: upgrade-bundles.sh
#
#         USAGE: ./upgrade-bundles.sh
#
#   DESCRIPTION: Upgrade all git submodules
#
#===============================================================================
set  -e

git submodule foreach git pull origin master

git submodule update --init
