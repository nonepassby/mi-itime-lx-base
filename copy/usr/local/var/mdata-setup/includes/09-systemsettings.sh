#!/bin/bash

if /native/usr/sbin/mdata-get selinux_disabled 1>/dev/null 2>&1; then
  [[ "$(/native/usr/sbin/mdata-get selinux_disabled)" == "yes" ]] && sed -i 's/SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
fi

if /native/usr/sbin/mdata-get timezone 1>/dev/null 2>&1; then
  TIMEZONE=$(/native/usr/sbin/mdata-get timezone)
  timedatectl set-timezone ${TIMEZONE} || true
fi