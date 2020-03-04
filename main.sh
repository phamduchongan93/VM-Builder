#!/bin/bash
# Project: VM Builder
# Description: script built to initialize a VM and provide accessibility to the program.
# Date: Wed Mar  4 03:00:30 EST 2020

### Add Libraries ###
source modules/kvm_check.sh
source	modules/check_argument.sh
source	modules/disk_manage.sh
source	modules/domain_destroy.sh

### Initialize Global Variable ### 
init ()
{
	 # assigning Storage Pool
  # these directories are storage for iso images
  images='/home/anpham/images'
  centos_images='/home/anpham/images/'
  ubuntu_images='/home/anpham/images/'
  windows='/home/anpham/images/'
  disk_location='/home/anpham/images/'

  # getting user input
  read -p "Name of VM: " vm_name
  disk_name="/home/anpham/storage_pool2/$vm_name.img"
  read -p "Disk Size (Gigabyte): " disk_size
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
        shift 
        disk_destroy "$1"
        domain_destroy "$1"
        ;;
      * | -*)
        virsh list --all
        ;; 
    esac
    shift 
  done 
}

main "$@" 
