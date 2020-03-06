#!/bin/bash
# Description: Create a vm based on given argument which are <vm_name> and <disk_name>
#
# ubuntu <vm_name> <disk_name> <disk_size> <iso_name>

ubuntu () 
{
  echo "Building ubuntu ..."
  create_disk && echo 'New disk created' || echo 'No disk created'
  echo "Path is $disk_ubuntu.img"
  echo "Building the ubuntu vm ..."
  virt-install -n "$1" --description "run in console mode" --ram=2048 --vcpu=2 --disk path="$2",bus=virtio,size="$3" --graphic none --location "$4" --extra-args="console=tty0 console=ttyS0,115200" --check all=off 
  ec=$? 
  [ "$ec" = 0 ] && echo "New ubuntu vm created"
}

centos ()
{
  # centos <vm_name> <disk_name> <disk_size> <image_location>
  echo 'Building the centos vm ...'
  virt-install -n "$1" 
         --description "centos run in console mode" \
         --os-type=Linux --os-variant centos7.0 \
         --ram-2048 --vcpu=2 \
         --disk path="2",bus=virtio,size="$3" --graphic none \
         --location "$4" \
         --extra-args="console=tty0 console=ttyS0,115200" \
         --check all=off \
  ec=$? 
  [ "$ec" = 0 ] && echo "New centos vm created"
}
