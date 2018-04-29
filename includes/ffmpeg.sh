#!/bin/bash

ffmpeg.execute() {
  util.message 'installing ffmpeg'

  local dirname='ffmpeg'
  local filename='ffmpeg-release-64bit-static.tar.xz'

  util.wget "http://johnvansickle.com/ffmpeg/releases/${filename}"
  mkdir "$dirname"
  tar -C "$dirname" --strip-components 1 -xf "$filename"

  cd "$dirname" || exit
  sudo chown root:root ffmpeg ffprobe
  sudo mv ffmpeg /usr/local/bin/
  sudo mv ffprobe /usr/local/bin/
  cd ../ || exit
  rm "$filename"
  rm -rf "$dirname"

  util.assertExecutable 'ffmpeg'
  util.assertExecutable 'ffprobe'
}
