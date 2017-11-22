#!/bin/bash

#vboxmanage startvm "my virtual machine" --type=headless|gui|sdl (one of those)
# So if your username is user, and virtualbox put your VMs in the default location, and you want headless...

VBoxManage setproperty autostartdbpath $HOME/Virt/VirtualBox

echo -n 'Enter the Virtual Box server name to autostart:'
read virtualName
VBoxManage modifyvm "$virtualName" --autostart-enabled on

read -rsp $'Press [Enter] to continue' -n1 key
