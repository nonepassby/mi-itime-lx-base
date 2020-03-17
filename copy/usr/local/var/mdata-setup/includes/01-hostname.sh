#!/bin/bash

if /native/usr/sbin/mdata-get sdc:hostname 1>/dev/null 2>&1; then
  HOSTNAME=$(/native/usr/sbin/mdata-get sdc:hostname)
  hostname $HOSTNAME
  hostname > /etc/hostname
  echo "127.0.0.1       localhost ${HOSTNAME}" > /etc/hosts
  echo "::1             localhost ip6-localhost ip6-loopback" >> /etc/hosts
fi