#!/bin/bash
restart_ssh=false
if /native/usr/sbin/mdata-get ssh-port 1>/dev/null 2>&1; then
  SSHPORT=$(/native/usr/sbin/mdata-get ssh-port)
  sed -i "s/#Port 22/Port $SSHPORT/g" /etc/ssh/sshd_config
  restart_ssh=true
fi

if /native/usr/sbin/mdata-get ssh-password 1>/dev/null 2>&1; then
  [[ "$(/native/usr/sbin/mdata-get ssh-password)" == "yes" ]] && sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config && restart_ssh=true
fi

[[ restart_ssh ]] && systemctl restart sshd

if /native/usr/sbin/mdata-get ssh-password 1>/dev/null 2>&1; then
  [[ "$(/native/usr/sbin/mdata-get selinux-disabled)" == "yes" ]] && sed -i 's/SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
fi