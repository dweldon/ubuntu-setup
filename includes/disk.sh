#!/bin/bash

disk.execute() {
  util.message 'adding ssd tweaks'

  util.progress 'updating fstab'
  local fstab='/etc/fstab'
  sudo cp $fstab "$fstab.old"
  sudo sed -i 's/errors=remount/noatime,errors=remount/' $fstab
  printf 'tmpfs /tmp tmpfs defaults,noatime,mode=1777 0 0' | sudo tee -a $fstab >& /dev/null

  util.progress 'changing swapiness and watches'
  local sysctl='/etc/sysctl.conf'
  util.append $sysctl 'vm.swappiness = 10' true
  util.append $sysctl 'fs.inotify.max_user_watches = 524288' true

  util.assertContains $fstab 'tmpfs'
  util.assertContains $fstab 'noatime'
  util.assertContains $sysctl 'swappiness'
  util.assertContains $sysctl 'max_user_watches'
}
