#!/bin/bash
# Project: VM Builder
# Description: bash script built to initialize a VM and provide accessibility to the program.
# Date: Wed Mar  4 03:00:30 EST 2020

### Add Libraries ###
source modules/kvm_check.sh
source modules/check_argument.sh
source modules/disk_manage.sh
source modules/domain_destroy.sh
source modules/virt_install.sh
source modules/files_check.sh
source modules/help.sh
source modules/clone_vm.sh

### Initialize Global Variable ### 
init ()
{
  # assigning Storage Pool
  # these directories are storages for iso images
  # can be added in bash and set up as enviroment variable
  centos_images='/home/anpham/Downloads/CentOS-8.1.1911-x86_64-dvd1/CentOS-8.1.1911-x86_64-dvd1.iso'
  ubuntu_images='/home/anpham/Downloads/ubuntu-20.10-desktop-amd64.iso'
  
  [ -z "$centos_images" ] && printf "Error: Cant find the centos_images"
  [ -z "$ubuntu_images" ] && printf "Error: Cant find the ubuntu"
   image_check "$ubuntu_images"
  # getting user input
  read -p "Name of VM: " vm_name
  disk_name="/home/anpham/storage_pool2/$vm_name.img"
  read -p "Disk Size (Gigabyte): " disk_size
}

main () 
{
  while [ -n "$1" ]
  do
    case "$1" in 
      --list | -l)
        virsh list --all 
        ;;
      --version)
        echo '1.0'
        ;;
      -b | --build) 
        kvm_check
        # choose Os type to build 
        shift
				init "$@" # export vm info and images checking
        case $1 in
          ubuntu)
            echo "Image Path: $ubuntu_images"
				    read -p "Press Any Key to Continue"
            ubuntu "$vm_name" "$disk_name" "$disk_size" "$ubuntu_images"
            ;;       
          centos)
            centos "$vm_name" "$disk_name" "$disk_size" "$centos_images"
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
      -s | --suspend)
        shift
        virsh suspend "$1" 
        ;; 
      -r | --resume)
        shift
        virsh suspend "$1" 
        ;; 
      --shutdown)
        shift 
        virsh shutdown "$1"
        ;;
      --auto-start)
        shift
        virsh autostart "$1" 
        ;;
      --clone)
        shift
        # clone_vm <source> <target>
        clone_vm  "$1" "$2"
        shift
        ;;
      --attach-disk)
        shift 
        attack_disk $1
        ;;
      * | -*)
        echo 'Invalid argument'
        help
        exit 1
        break
        ;; 
    esac
    shift 
  done 
}

main "$@" 
