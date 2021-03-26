#!/bin/bash
create_disk ()
{
  [ ! -e "$disk_name" ] && qemu-img create -f qcow2 -o size="$disk_size"  "$disk_name" ||  echo 'Disk already built'
}
