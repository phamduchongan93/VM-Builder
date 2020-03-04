#!/bin/bash 

disk_destroy ()
{
  [ -n "$(virsh list --all | grep -i $1)" ] && virsh dumpxml --domain "$1" | xmlstarlet sel -t -v '//source/@file' -nl | head -1 || echo ''
}

disk_destroy "test1"
