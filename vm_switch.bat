#/usr/bin/env bats 

load vm_switch

@test "checking arguments for the command" {
  main -b ubuntu
  ec="$?"
  [ "$ec" -eq 0 ]  
}

@test "argument check" {
  run check_argument &&  ec="$?"
  [ "$ec" -eq 0 ] 
}

@test "ubuntu build test" {
  run ubuntu && ec="$?"
  [ "$ec" -eq 0 ]
}
