#!/bin/bash

node.latest() {
  local url='https://nodejs.org/dist/latest/'
  local pattern1='>node-v.+-linux-x64.tar.gz'
  local pattern2='[0-9]+\.[0-9]+\.[0-9]+'
  echo "$(curl --silent "$url" | egrep -o "$pattern1" | egrep -o "$pattern2")"
}

node.installModule() {
  local module="$1"

  util.progress "installing $module"
  npm install -g "$module" >& /dev/null
}

node.install() {
  local version="$1"

  local filename="node-v${version}-linux-x64.tar.gz"
  local url="https://nodejs.org/dist/v${version}/${filename}"
  local nodeDir="$HOME/local"

  # Remove previous installation
  util.progress 'removing'
  rm -rf "$HOME/.npm"
  rm -rf "$HOME/.node-gyp"
  rm -rf "$nodeDir"

  # Download binaries
  util.progress 'downloading'
  util.wget "$url"
  mkdir -p "$nodeDir"
  tar -C "$nodeDir" --strip-components 1 -xzf "$filename"
  rm "$filename"

  # Install modules
  local module
  local modules=(
    yarn
    coffeelint
    coffee-script
    npm-check-updates
  )
  for module in "${modules[@]}"; do
    node.installModule "$module"
  done
}

node.execute() {
  local bashrc="$HOME/.bashrc"
  local nodeDir="$HOME/local/bin"

  util.message 'installing node'

  # Add the node path to .bashrc
  util.progress 'updating .bashrc'
  util.append "$bashrc" '# node.js'
  util.append "$bashrc" "export PATH=\"$nodeDir:\$PATH\""
  util.append "$bashrc"

  # Modify the current environment variables
  PATH="$nodeDir:$PATH"

  node.install "$(node.latest)"
  util.assertExecutable 'node'
  util.assertExecutable 'npm'
}
