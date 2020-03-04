#!/bin/bash
# Project: VM Builder
# Description: script built to initialize a VM and provide accessibility to the program.

### Add Libraries ###
source ./kvm_check.sh
source	./check_argument.sh
source	./disk_destroy.sh
source	./domain_destroy.sh

### Initialize Global Variable ### 
init ()
{
  images='/home/anpham/images'
  centos_images='/home/anpham/images/'
  ubuntu_images='/home/anpham/images/'
  windows='/home/anpham/images/'
  disk_location='/home/anpham/images/'
  [ "$1" == '-b' ] && os_type="$2"
  [ "$1" == '-b' ] && os_type="$2"
  read -p "Name of VM: " vm_name
  disk_name="/home/anpham/storage_pool2/$vm_name.img"
  read -p "Disk Size (Gigabyte): " disk_size
}

### Build VM ### 

ubuntu () 
{
  echo "Building ubuntu ..."
  create_disk && echo 'New disk created' || echo 'No disk created'
  echo "Path is $disk_ubuntu.img"
  echo "Building the ubuntu vm ..."
  virt-install -n "$vm_name" --description "run in console mode" --ram=2048 --vcpu=2 --disk path="$disk_name",bus=virtio,size=60 --graphic none --location="/home/anpham/images/ubuntu-18.04.4-server-amd64.iso" --extra-args="console=tty0 console=ttyS0,115200" --check all=off && ec=$?
  [ "$ec" = 0 ] && echo "New ubuntu vm created"
}

centos ()
{
  echo 'Building the centos vm ...'
  virt-install -n ubuntu --description "run in console mode" --os-type=Linux --os-variant centos7.0 --ram-2048 --vcpu=2 --disk path="",bus=virtio,size=60 --graphic none --location ~/images/ubuntu-18.04.3-desktop-amd64.iso --extra-args="console=tty0 console=ttyS0,115200" --check all=off 
}

main () 
{
  while [ -n "$1" ]
  do
				kvm_check
    case "$1" in 
      --list | -l)
        virsh list --all 
        ;;
      --version)
        echo '1.0'
        ;;
      -b | --build) 
        # choose Os type to build 
        shift
        init "$@"
								case $1 in
										ubuntu)
            ubuntu 
												;;       
										centos)
												echo 'centos built'
												;;   
										*)
												echo "Invalid: Require 'Ubuntu' or 'Centos' argument"
												;;
								esac 
        ;;
      -d | --destroy)
        # destroy installed vm
        disk_destroy "$vm_name"
        domain_destroy "$vm_name"
        ;;
      * | -*)
        virsh list --all
        ;; 
    esac
    shift 
  done 
}
### Program Start ### 
main "$@" 
