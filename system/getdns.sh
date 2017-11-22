#!/bin/bash
read -p "Enter wireless name:" name
nmcli device show $name | grep IP4.DNS
read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...'
