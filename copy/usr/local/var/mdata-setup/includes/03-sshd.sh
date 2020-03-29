#!/bin/bash
restart_ssh=false
if /native/usr/sbin/mdata-get ssh_port 1>/dev/null 2>&1; then
  SSHPORT=$(/native/usr/sbin/mdata-get ssh_port)
  gsed -i "s/#Port 22/Port $SSHPORT/g" /etc/ssh/sshd_config
  restart_ssh=true
fi

if /native/usr/sbin/mdata-get ssh_password_auth 1>/dev/null 2>&1; then
  [[ "$(/native/usr/sbin/mdata-get ssh_password_auth)" == "yes" ]] && gsed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config && restart_ssh=true
fi

[[ restart_ssh ]] && systemctl restart sshd