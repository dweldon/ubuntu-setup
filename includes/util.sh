#!/bin/bash

util.fail() {
  local message="$1"
  echo "ERROR: $message" && exit 1
}

util.message() {
  local message="$1"
  echo "- $message"
}

util.progress() {
  local message="$1"
  printf "\t%s\n" "$message"
}

util.installPackage() {
  local name="$1"
  util.progress "installing $name"
  sudo apt-get -y install "$name" >& /dev/null
}

util.assertContains() {
  local path="$1"
  local string="$2"
  if ! grep -q "$string" "$path"; then
    util.fail "$path does not contain $string"
  fi
}

util.assertExecutable() {
  local filename="$1"
  hash "$filename" >& /dev/null || util.fail "$filename not installed"
}
