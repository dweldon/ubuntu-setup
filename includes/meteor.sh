#!/bin/bash

meteor.execute() {
  local path="$HOME/.bashrc"

  util.message 'installing meteor'
  curl -s https://install.meteor.com | /bin/sh >& /dev/null

  util.append "$path" '# meteor'
  util.append "$path" 'export METEOR_PACKAGE_DIRS="$HOME/Work/packages"'
  util.append "$path"

  util.assertContains "$path" 'METEOR_PACKAGE_DIRS'
  util.assertExecutable 'meteor'
}
