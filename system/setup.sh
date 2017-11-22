#!/bin/bash
source Util.inc.sh

echo "--------------------------------------------------------------------------------"
echo "| Workstation Setup Script                                                     |"
echo "--------------------------------------------------------------------------------"

cd ~

if ask "Add Data partition to fstab?" N; then
  sudo echo "LABEL=Data	/media/data	ext4	user,grpid,exec,relatime	0	0" >> /etc/fstab
  pause $?
    if ask "Do you wish to reboot to apply fstab changes?" Y; then
      sudo reboot
    fi
fi

if ask "Copy redshift.conf to .config?" N; then
  cp -v .config/redshift.conf ~/.config/redshift.conf
  pause $?
fi

if ask "Add PATH and JAVA_HOME to .profile?" N; then
  echo "export PATH=\"\$PATH:/media/data/Programs/nodejs/bin:/media/data/Programs/tools/apache-maven-3.3.3/bin:/media/data/Programs/sdks/jdk1.8.0_66/bin\"" >> ~/.profile
  echo "export JAVA_HOME=/media/data/Programs/sdks/jdk1.8.0_66" >> ~/.profile
  pause $?
fi

if ask "Update .bash_profile with JAVA_HOME?" N; then
  touch ~/.bash_profile
  echo "source ~/.profile" >> ~/.bash_profile
  echo "export JAVA_HOME=/media/data/Programs/sdks/jdk1.8.0_66" >> ~/.bash_profile
  pause $?
fi

if ask "Update udev rules?" N; then
  sudo cp ./files/etc/udev/rules.d/*.rules /etc/udev/rules.d/
  pause $?
fi

if ask "Add graphics-drivers to apt?" N; then
  sudo add-apt-repository ppa:graphics-drivers/ppa
  sudo apt update
  pause $?
fi

if ask "Install default programs?" N; then
  sudo apt update
  sudo apt install gkrellm gkrelltop vim net-tools chromium-browser yubikey-personalization-gui vlc nmap putty netbeans rabbitvcs-nautilus remmina-plugin-rdp remmina-plugin-vnc remmina nikto finger docker.io
  sudo apt dist-upgrade
  pause $?
fi

if ask "Add this user to Docker group?" N; then
  sudo usermod -aG docker $USER
  pause $?
fi

if ask "The following section creates symlinks to your home directory.  Do you wish to continue?" N; then

  read -p "Enter user directory in /media/data:" USERDIR

  if ask "Symlink 'Downloads' directory in /media/data?" N; then
    DIR=$USERDIR/Downloads
    if [ "$(ls -A $DIR)" ]; then
      echo "Please remove all files from $DIR so this can create the symlink"
    else
      rm -R $DIR
    fi

    ln -s /media/data/$DIR
    pause $?
  fi

  if ask "Symlink 'Pictures' directory in /media/data?" N; then
    read -p "Enter user directory in /media/data:" DIR
    if [ "$(ls -A $DIR)" ]; then
      echo "Please remove all files from $DIR so this can create the symlink"
    else
      rm -R ~/Pictures
    fi

    ln -s /media/data/$DIR/Pictures
    pause $?
  fi

  if ask "Symlink 'devel' directory in /media/data?" N; then
    read -p "Enter user directory in /media/data:" DIR
    if [ "$(ls -A $DIR)" ]; then
      echo "Please remove all files from $DIR so this can create the symlink"
    else
      rm -R ~/devel
    fi

    ln -s /media/data/$DIR/devel
    pause $?
  fi

  if ask "Symlink 'develwork' directory in /media/data?" N; then
    read -p "Enter user directory in /media/data:" DIR
    if [ "$(ls -A $DIR)" ]; then
      echo "Please remove all files from $DIR so this can create the symlink"
    else
      rm -R ~/develwork
    fi

    ln -s /media/data/$DIR/develwork
    pause $?
  fi

  if ask "Symlink 'Programs' directory in /media/data?" N; then
    ln -s /media/data/Programs
    pause $?
  fi

fi

echo Done!
