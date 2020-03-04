#!/bin/bash 
disk_destroy ()
{
  [ -n "$(virsh list --all | grep -i $1)" ] && virsh dumpxml --domain "$1" | grep 'source file' || echo ''
}

disk_destroy "test1"
