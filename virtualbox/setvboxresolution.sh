#!/bin/bash
#Where N can be one of 0, 1, 2, 3, 4 or 5 referring to the 640x480, 800x600, 1024x768, 1280x1024, 1440x900, 1920x1200 screen resolution respectively.
VBoxManage setextradata "VM name" VBoxInternal2/EfiGopMode <N>

#Stuck on boot: "Missing Bluetooth Controller Transport"
VBoxManage modifyvm '<YourVMname>' --cpuidset 1 000206a7 02100800 1fbae3bf bfebfbff

#Set CPU for earlier than Haswell.
VBoxManage modifyvm <Name of virtual machine> --cpuidset 00000001 000306a9 00020800 80000201 178bfbff
