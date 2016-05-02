#!/bin/bash

#vboxmanage startvm "my virtual machine" --type=headless|gui|sdl (one of those)

echo -n 'Enter the Virtual Box server name to autostart:'
read virtualName
vboxmanage startvm $virtualName --type=gui 

read -rsp $'Press [Enter] to continue' -n1 key
