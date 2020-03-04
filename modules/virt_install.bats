#!/bin/env bats

source virt_install.sh
source create_disk.sh
source disk_destroy.sh
source domain_destroy.sh 

@test 'destroy a domain /vm ' {
  domain_destroy "test1"; ec="$?"
  [ "$ec" = 0 ] 
}

@test 'destroy the old disk' {
  disk_destroy "test1" ; ec="$?"
  [ "$ec" = 0 ] 
}

@test 'try to build ubuntu' {
  ubuntu "test1" "30G" ; ec="$?"
  [ "$ec" = 0 ]  
} 
