#!/bin/bash
PASSWORDLIST=(`/native/usr/sbin/mdata-list | grep -e '_pw$'`) 2>&1
[[ ${#PASSWORDLIST[@]} == 0 ]] && exit 0

for USERPASSWORD in ${PASSWORDLIST[@]}
do
  if /native/usr/sbin/mdata-get $USERPASSWORD 1>/dev/null 2>&1; then
    USERNM=${USERPASSWORD%_*}
    USERPW=$(/native/usr/sbin/mdata-get $USERPASSWORD)
    echo $USERNM:$USERPW | chpasswd || true
  fi
done