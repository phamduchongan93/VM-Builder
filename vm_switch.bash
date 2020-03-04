#!/bin/bash
# Description: script built to initialize a VM and provide accessibility to the program.

set -e
### Check argument ###
check_argument ()
{
  echo "Function name:  ${FUNCNAME}"
  echo "The number of positional parameter : $#"
  echo "All parameters or arguments passed to the function: '$@'"
}
 
### Initialize Global Variable ### 

init ()
{
  images=/home/anpham/images  
  centos_images=/home/anpham/images/
  ubuntu_images=/home/anpham/images/
  windows=/home/anpham/images/
  disk_location=/home/anpham/images/
  ac="$#"
  check_argument "$@"
}

### Build VM ### 

ubuntu () 
{
  virt-install -n ubuntu --description "run in console mode" --os-type=Linux --ram-2048 --vcpu=2 --disk path=/var/lib/libvirt/images/ubuntu-virt,bus=virtio,size=60 --graphic none --location ~/images/ubuntu-18.04.3-desktop-amd64.iso --extra-args="console=tty0 console=ttyS0,115200" --check all=off 
}

centos ()
{
  echo 'Centos built'
}

### Pre-check KVM ### 
kvm_check () 
{
  echo 'Checking virtualization ... ' 
  if [ "$(lsmod | grep kvm)" ]
  then 
    echo 'Done'
  else
    echo 'Not found'
    exit 1
  fi
}

### Passing Argument ### 
main () 
{
  while [ "$ac" -gt 0 ]
  do
				#kvm_check
    case "$1" in 
      --list | -l)
        virsh list --all 
        ;;
      --version)
        echo '1.0'
        ;;
      -b | --build) 
        # choose Os type to build 
								case $os_type in
										ubuntu)
											 ubuntu
												;;       
										centos)
												echo centos
												;;   
										*)
												echo "Invalid: Require Ubuntu or Centos argument"
												;;
								esac 
        ;;
      * | -*)
        virsh list --all
        ;; 
    esac
    exit 
  done 
}
### Program Start ### 
#init "$@"
#main 
