#!/bin/sh

VBoxManage modifyvm "OS X Mavericks" --cpuidset 00000001 000306a9 04100800 7fbae3ff bfebfbff
VBoxManage setextradata "OS X Mavericks" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "MacBookPro11,3"
VBoxManage setextradata "OS X Mavericks" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
VBoxManage setextradata "OS X Mavericks" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "IHateApple"
VBoxManage setextradata "OS X Mavericks" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage setextradata "OS X Mavericks" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1