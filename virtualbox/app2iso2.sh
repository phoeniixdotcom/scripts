#!/bin/sh
# http://blog.frd.mn/install-os-x-10-10-yosemite-in-virtualbox/

iesd -i "/Applications/Install OS X El Capitan.app” -o elcapitan.dmg -t BaseSystem
hdiutil convert elcapitan.dmg -format UDSP -o elcapitan.sparseimage

hdiutil mount "/Applications/Install OS X El Capitan.app/Contents/SharedSupport/InstallESD.dmg"

hdiutil mount elcapitan.sparseimage

cp "/Volumes/OS X Install ESD/BaseSystem."* "/Volumes/OS X Base System/"

hdiutil unmount "/Volumes/OS X Install ESD/"

hdiutil unmount "/Volumes/OS X Base System/"

diskutil unmountDisk $(diskutil list | grep "OS X Base System" -B 4 | head -1) 
diskutil unmountDisk $(diskutil list | grep "OS X Install ESD" -B 4 | head -1) 

hdiutil convert elcapitan.sparseimage -format UDZO -o elcapitanfixed.dmg
