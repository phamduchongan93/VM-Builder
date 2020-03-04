#!/bin/bash 
# Description: Remove and Create Disk. 
# Date: Wed Mar  4 03:54:27 EST 2020
# creat_disk <diskname> <disksize>

create_disk ()
{
  [ ! -e "$1" ] && qemu-img create -f qcow2 -o size="$2"  "$1" ||  echo 'Disk already built'
}

disk_destroy ()
{
  local disk_path="$(virsh dumpxml --domain "$1" | xmlstarlet sel -t -v '//source/@file' -nl | head -1)"
  [ -n "$(virsh list --all | grep -i $1)" ] && rm -f "$disk_path" || echo ''
}

