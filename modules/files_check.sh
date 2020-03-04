#!/bin/bash

image_check () 
{
  [ ! -f "$1" ] && echo "Couldn't find the iso image. Please fill in path in main.sh file " || echo "Found ISO image"
}

