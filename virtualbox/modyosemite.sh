#!/bin/sh

VBoxManage modifyvm "OS X Yosemite" --cpuidset 00000001 000306a9 00020800 80000201 178bfbff
#VBoxManage modifyvm "OS X Yosemite" --cpuidset 00000001 000306a9 04100800 7fbae3ff bfebfbff
VBoxManage setextradata "OS X Yosemite" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "MacBookPro11,3"
VBoxManage setextradata "OS X Yosemite" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
VBoxManage setextradata "OS X Yosemite" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "IHateApple"
VBoxManage setextradata "OS X Yosemite" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage setextradata "OS X Yosemite" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
