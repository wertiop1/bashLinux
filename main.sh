#!/bin/bash

function checkRoot() {
  if [[ $EUID -ne 0 ]]; then #!=> confirms sudo access
    echo "This script must be run as root"
    echo "Please use sudo ./master.sh to run"
    exit
  fi
}

function pause() {
  echo -n "Press ENTER to continue: "
  read
  clear
}

function ask() {
  echo -n $1 "(y|N): "
  read answer
  if [ "${answer^^}" == "Y" ] || [ "${answer^^}" == "YE" ] || [ "${answer^^}" == "YES" ]; then
	  $2
  fi
}

function listUsers() {
  cat /etc/passwd | cut -d: -f1
}

function reinstall() {
  echo "Reinstalling package: $1"
  apt purge $1 -y
  apt install $1 -y
}

function install() {
  for package in $@; do
    installed=$(dpkg -l | grep package)
    if [ installed ]; then
      ask "$package already exists, would you like to reinstall?" "reinstall $package"
    else
      apt install $package -y 
    fi 
  done
}

function main() {

}

main  

