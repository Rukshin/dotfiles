#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Bitbucket Repo
# @raycast.mode compact
# @raycast.packageName Bitbucket

# Optional parameters:
# @raycast.icon icons/bitbucket.png
# @raycast.argument1 { "type": "text", "placeholder": "Repository", "optional":true }

# Documentation:
# @raycast.description Open bitbucket repository
# @raycast.author Enric Arandes
# @raycast.authorURL https://github.com/earandes

url="https://collaboration.msi.audi.com/stash/dashboard"

case $1 in
  "admb")
   url="https://collaboration.msi.audi.com/stash/projects/AWSIFT/repos/awsiadm_adm-backend/browse"
    ;;
  "admm")
    url="https://collaboration.msi.audi.com/stash/projects/AWSIFT/repos/awsiadm_adm-mail-service/browse"
    ;;
  "rsafe")
    url="https://collaboration.msi.audi.com/stash/projects/AWSIFT/repos/awsiadm_adm-rsafe-proxy/browse"
    ;;
  "library")
   url="https://collaboration.msi.audi.com/stash/projects/AWSIFT/repos/awsiadm_adm-library/browse"
    ;;
  "config")
   url="https://collaboration.msi.audi.com/stash/projects/SPRCCSADM/repos/configuration_sprccsadm/browse"
    ;;
esac

open $url
