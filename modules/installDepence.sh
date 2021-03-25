#!/bin/bash
# Description: install required packages and kvm.

installDependency () {
  apt install  qemu-kvm libvirt-daemon-system
}

userAdd () {
  sudo adduser $USER libvirt
}
