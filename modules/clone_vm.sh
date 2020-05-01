#!/bin/bash
# Description: clone the current running vm to a new vm with new qcow2 disk format

clone_vm () {
  # clone-disk "$source_vm" "$target_vm"
  local source_vm="$1"
  local target_vm="$2"

  virt-clone --original "$source_vm" --name "$target_vm" -f "/var/lib/libvirt/images/$target_vm.qcow2"
} 
