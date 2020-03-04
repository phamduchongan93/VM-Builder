#!/bin/bash

kvm_check () 
{
  echo 'Checking virtualization ... ' 
  [ "$(lsmod | grep kvm)" ] && ec="$?"
  if [ "$ec" = 0 ]
  then 
    echo 'KVM found'
  else
    echo 'Not found'
    exit 1
  fi
}
