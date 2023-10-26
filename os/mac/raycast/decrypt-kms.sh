#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Decrypt AWS KMS value
# @raycast.mode silent
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon 🔓

# Documentation:
# @raycast.description Decrypt AWS KMS value.


$HOME/.dotfiles/bin/sdot private decrypt_kms \"$(pbpaste)\"
echo "Decrypted key copied to clipboard"

