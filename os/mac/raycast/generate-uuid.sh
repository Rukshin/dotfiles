#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Generate UUID
# @raycast.mode silent
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon 💻

# Documentation:
# @raycast.description Generates a UUID and copies it to the clipboard.

$HOME/.dotfiles/bin/sdot utils uuid_code
echo "UUID Generated"
