#!/bin/bash
source Util.inc.sh

echo "--------------------------------------------------------------------------------"
echo "| Show DNS settings used by the OS                                             |"
echo "| *buntu 15+                                                                   |"
echo "--------------------------------------------------------------------------------"

cd ~

read -p "Enter your network interface name (eth0):" IFACE </dev/tty

nmcli device show $IFACE | grep IP4

read -n1 -rsp $'\nPress any key to continue or Ctrl+C to exit...'
