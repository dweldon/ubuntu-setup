#!/bin/bash

cleanup.execute() {
  util.message 'cleaning up'

  util.progress 'removing amazon'
  sudo rm -f '/usr/share/applications/ubuntu-amazon-default.desktop'

  util.progress 'removing examples'
  rm -f "$HOME/examples.desktop"
}
