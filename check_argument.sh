#!/bin/bash

argument_check ()
{
  echo "Function name:  ${FUNCNAME}"
  echo "The number of positional parameter : $#"
  echo "All parameters or arguments passed to the function: '$@'"
}
