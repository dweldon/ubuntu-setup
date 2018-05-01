#!/bin/bash

packages.execute() {
  util.message 'installing packages'

  local package
  local packages=(
    ntp
    curl
    meld
    tree
    tofrodos
    mediainfo
    shellcheck
    chromium-browser
  )
  for package in "${packages[@]}"; do
    util.installPackage $package
  done
}
