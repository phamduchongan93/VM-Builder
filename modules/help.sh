#!/bin/bash

help () {
  echo "Usuage: $(basename $0) <-b|-l|-d> [ubuntu] [centos] [] "
  echo ''
  echo 'Where:'
  echo '  -h,--help    show the help page'
  echo '  -b,--build   build an vm' 
  echo '  -l,--list    show current running vm'
  echo '  -d,--destroy destroy the vm'
  echo '  --clone      clone the current running vm'
  echo 'Example:'
  echo "  $(basename $0) -l             List current running system"
  echo "  $(basename $0) -b ubuntu      Build a new ubuntu machine" 
	echo "  $(basename $0) -d <vm_name>   Destroy the domain or vm name"
	echo ""

}                      


