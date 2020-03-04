#!/bin/env bats
source kvm_check.sh
@test "check kvm" {
  kvm_check  ; ec="$?"
  [ $ec = 0 ]
}
