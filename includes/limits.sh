#!/bin/bash

limits.execute() {
  util.message 'increasing file limits'

  local ulimit=16384
  local limits='/etc/security/limits.conf'

  util.append $limits "* soft nofile $ulimit" true
  util.append $limits "* hard nofile $ulimit" true
  util.assertContains $limits $ulimit

  util.message 'increasing inotify watchers'

  local wlimit=524288
  local sysctl='/etc/sysctl.conf'

  util.append $sysctl "fs.inotify.max_user_watches = $wlimit" true
  util.assertContains $sysctl $wlimit
}
