#!/bin/bash
# Description: Create a vm based on given argument which are <vm_name> and <disk_name>
source create_disk.sh
# ubuntu <vm_name> <disk_name> 

ubuntu () 
{
  echo "Building ubuntu ..."
  create_disk && echo 'New disk created' || echo 'No disk created'
  echo "Path is $disk_ubuntu.img"
  echo "Building the ubuntu vm ..."
  virt-install -n "$1" --description "run in console mode" --ram=2048 --vcpu=2 --disk path="$2",bus=virtio,size=60 --graphic none --location="$2" --extra-args="console=tty0 console=ttyS0,115200" --check all=off & 
  ec=$? 
  [ "$ec" = 0 ] && echo "New ubuntu vm created"
}

centos ()
{
  echo 'Building the centos vm ...'
  virt-install -n ubuntu --description "run in console mode" --os-type=Linux --os-variant centos7.0 --ram-2048 --vcpu=2 --disk path="",bus=virtio,size=60 --graphic none --location ~/images/ubuntu-18.04.3-desktop-amd64.iso --extra-args="console=tty0 console=ttyS0,115200" --check all=off 
}
