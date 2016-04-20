#!/bin/bash
source Util.inc.sh

echo "--------------------------------------------------------------------------------"
echo "| Workstation Setup Script                                                     |"
echo "--------------------------------------------------------------------------------"

cd ~

if ask "Add Main partition to fstab?" N; then
  sudo echo "LABEL=Main	/media/main	ext4	user,grpid,exec,relatime	0	0" >> /etc/fstab
  pause $?
fi

if ask "Copy redshift.conf to .config?" N; then
  cp -v .config/redshift.conf ~/.config/redshift.conf
  pause $?
fi

if ask "Add JAVA_HOME to .profile?" N; then
  echo "export PATH=\"\$PATH:/media/main/programs/nodejs/bin:/media/main/programs/tools/apache-maven-3.3.3/bin:/media/main/programs/sdks/jdk1.8.0_66/bin\"" >> ~/.profile
  pause $?
fi

if ask "Update .bash_profile?" N; then
  touch ~/.bash_profile
  echo "source ~/.profile" >> ~/.bash_profile
  echo "export JAVA_HOME=/media/main/programs/sdks/jdk1.8.0_66" >> ~/.bash_profile
  pause $?
fi

if ask "The following section creates symlinks to your home directory.  Do you wish to continue?" N; then

  if ask "Symlink Downloads directory in /media/main?" N; then
    read -p "Enter user directory in /media/main:" DIR
    #rm -R ~/Downloads
    ln -s /media/main/$DIR/Downloads
    pause $?
  fi

  if ask "Symlink Pictures directory in /media/main?" N; then
    read -p "Enter user directory in /media/main:" DIR
    #rm -R ~/Pictures
    ln -s /media/main/$DIR/Pictures
    pause $?
  fi

  if ask "Symlink devel directory in /media/main?" N; then
    read -p "Enter user directory in /media/main:" DIR
    #rm -Rf ~/devel
    ln -s /media/main/$DIR/devel
    pause $?
  fi

fi

echo Exiting...
