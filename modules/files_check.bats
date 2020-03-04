#!/bin/env bats

source files_check.sh

@test 'image_check' {
  image_check "/home/anpham/images/ubuntu-18.04.4-server-amd64.iso" ; ec="$?"
  [ "$ec" = 0 ]
}

