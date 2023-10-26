#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Remove containers
# @raycast.mode silent
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon 🐳

# Documentation:
# @raycast.description Prune docker containers.

$HOME/.dotfiles/bin/sdot docker remove_containers &
wait
echo "Docker containers pruned"
