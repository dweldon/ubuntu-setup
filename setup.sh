#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=/dev/null
source "$DIR/includes/util.sh"

setup() {
  local name
  local names=(packages bashrc git)
  for name in "${names[@]}"; do
    # shellcheck source=/dev/null
    source "$DIR/includes/${name}.sh"
    $name.execute
  done
}

setup
exit 0
