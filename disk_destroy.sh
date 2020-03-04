#!/bin/bash 
disk_destroy ()
{
  [ $(virsh list --all | grep -i "$1") ] && virsh dumpxml --domain "$1" | grep 'source file' || echo ''
}
