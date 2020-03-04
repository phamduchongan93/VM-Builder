#!/bin/bash
# Description: Destroy a domain/vm 

domain_destroy ()
{
  if [ -n "$(virsh list --all | grep -i "$1")" ];
  then
				virsh shutdown "$1"
				virsh destroy "$1"
				virsh undefine "$1" 
  fi
}

