#!/bin/bash
#
# setupAnsible.sh
#    usage: ./setupAnsible.sh
#
# Description:
# This script will download the devel tarball for ansible, extract it, 
# build deb package and then install it.
#

# --------------------------------------------------------- # 
# exists()
# returns 0 if command exists, 1 otherwise
# --------------------------------------------------------- # 
function exists() {
  if hash $1 2>/dev/null; then
    return 0
  fi

  return 1
}

# --------------------------------------------------------- # 
# installAnsible()
# Installs desired version of ansible if it's not installed
# --------------------------------------------------------- # 
function installAnsible() {
  echo "Starting..."
  ANSIBLE_INSTALL_DIR=/tmp

  if exists ansible; then
    echo "Ansible is installed, proceed."
    return 0
  fi

  echo "Downloading ansible"
  wget -O $ANSIBLE_INSTALL_DIR/ansible-devel.tgz https://github.com/ansible/ansible/archive/devel.tar.gz

  echo "Extract ansible to $ANSIBLE_INSTALL_DIR"
  tar xzf $ANSIBLE_INSTALL_DIR/ansible-devel.tgz -C $ANSIBLE_INSTALL_DIR

  echo "build deb"
  apt-get install -y cdbs python-support
  cd $ANSIBLE_INSTALL_DIR/ansible-devel
  make deb
  
  echo "install deb package"
  dpkg -i $ANSIBLE_INSTALL_DIR/ansible_*_all.deb
  
  # Fix dependencies after package installation.
  apt-get install -fy

  echo "Cleaning up downlaoded dependencies"
  rm -rf $ANSIBLE_INSTALL_DIR/ansible*
}


# Make sure script is executed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

installAnsible
