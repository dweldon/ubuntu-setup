#!/bin/bash

extras.execute() {
  util.message 'adding extras'
  sudo apt-get -y install 'ubuntu-restricted-extras'
}
