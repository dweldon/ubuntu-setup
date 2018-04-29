#!/bin/bash

bashrc.update() {
  local path="$1"
  local root="$2"

  if [ -z "$root" ]; then
    touch "$path"
    util.append "$path" '# editor aliases'
    util.append "$path" "alias n='nano -w'"
    util.append "$path" 'g(){ gedit "$@" > /dev/null 2>&1; }'
    util.append "$path"
  else
    sudo touch "$path"
    util.append "$path" '# editor aliases' true
    util.append "$path" "alias n='nano -w'" true
  fi
}

bashrc.execute() {
  util.message 'editing .bashrc'
  bashrc.update "$HOME/.bashrc"
  bashrc.update '/root/.bashrc' true
  util.assertContains "$HOME/.bashrc" 'nano'
}
