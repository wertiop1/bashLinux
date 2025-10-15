#!/bin/bash
echo "Executing Script ..."
if [[ $EUID -ne 0 ]]; then #!=> confirms sudo access
  echo "This script must be run as root"
  echo "Please use sudo ./master.sh to run"
  exit
fi


#Set Up
echo "Make sure to read the README in its entirety."
echo ""
echo "Make sure to READ and DO all the forensics questions before running this script."
echo ""
echo ""
echo "Master Linux Script for 2024-2025"
echo "CTRL+C to exit"
echo ""

#Find Home Directory
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

#Make Logging
echo "Creating Log Folder ~/log"
mkdir $USER_HOME/log

echo "Creating Log Files"
echo -n "" > $USER_HOME/log/sockStats.log
echo -n "" > $USER_HOME/log/mediafiles.log
echo -n "" > $USER_HOME/log/cronjoblist.log
echo -n "" > $USER_HOME/log/processStats.log

#Make backup folder
echo "Creating Backup Folder ~/backup"
mkdir $USER_HOME/backup

#Alias
unalias -a
echo "All Aliases removed"

#Lock Root
usermod -L root
echo "Root has been locked. Use 'usermod -U root' to unlock it"

#Startup Scripts
cp /etc/rc.local $USER_HOME/backup/
echo > /etc/rc.local
echo 'exit 0' >> /etc/rc.local
echo "Any startup scripts have been removed."

#Firewall
echo "Enable Firewall? (y|n)"
read -r FIREWALL
if [ "$FIREWALL" = "y" ]; then
    echo "Installing and Enabling Firewall"
    apt install ufw -y
    ufw reset
    ufw enable
fi

#permissons
chmod +x permissions.sh
./permisions.sh 

#services
chmod +x service.sh
./service.sh

#Passwords
chmod +x password.sh
./password.sh

#Prohibited Files
chmod +x prohibitedFiles.sh
./prohibitedFiles.sh

#Package Audit
chmod +x package.sh
./package.sh

#LightDM guest
echo "Using Light DM? (y|n)"
read -r LightDM

if [[ "$LightDM" == "y" ]]; then

  echo "Disable (Light DM) guest? (y|n)"
  read -r GUEST

  if [[ "$GUEST" == "y" ]]; then
    echo "disabling guest account"
    cp /etc/lightdm/lightdm.conf $USER_HOME/backup/lightdm.conf.old
    echo "allow-guest=false" >> /etc/lightdm/lightdm.conf
  fi
fi 
#CronJobs

echo "Log Cron Jobs? (y|n)"
read -r CRONLOG

if [[ "$CRONLOG" == "y" ]]; then
  echo "Outputting cronjobs to $USER_HOME/log/cronjoblist.log"
  touch $USER_HOME/log/cronjoblist.log
  crontab -l >> $USER_HOME/log/cronjoblist.log

  echo "Checking for cronjob Black and Whitelist, outputting to $USER_HOME/log/CronList.log"
  touch $USER_HOME/log/CronList.log
  cp /etc/cron.allow >> $USER_HOME/log/CronList.log
  cp /etc/cron.deny >> $USER_HOME/log/CronList.log
fi

echo "Remove Cron Jobs? (y|n)?"
echo RCRON
if [[ "$RCRON" == "y" ]]; then
  touch $USER_HOME/log/cronjoblist.log
  crontab -l >> $USER_HOME/log/cronjoblist.log
  crontab -r
fi


#Network

echo "Log Processes? (y|n)"
read -r LOG_PS
if [ "$PS_LOG" = "y" ]; then
  echo "Outputting processes to $USER_HOME/log/processStats.log"
  ps axk start_time -o start_time,pid,user,cmd >> $USER_HOME/backup/processStats.log
fi

echo "Log Networks Connections? (y|n)"
read -r LOG_NETSTATS

if [ "LOG_NETSTATS" = "y" ]
then
  echo "finding open connections and outputting to $USER_HOME/log/sockStats.log"
  ss -an4 > $USER_HOME/log/sockStats.log
fi

echo "Install Updates? (y|n)"
echo "Make sure all update conf files are configured correctly"
read -r UPDATES

if [ "$UPDATES" = "y" ]; then
  echo "Updating Packages"
  apt update && apt full-upgrade
  snap refresh --list

  echo "Enable Auto Updates? (y|n)"
  read -r AUTO_UPDATES

  if [ "$AUTO_UPDATES" = "y" ]; then
    chmod 777 /etc/apt/apt.conf.d/10periodic
    cp /etc/apt/apt.conf.d/10periodic $USER_HOME/backups/
    echo -e "APT::Periodic::Update-Package-Lists \"1\";\nAPT::Periodic::Download-Upgradeable-Packages \"1\";\nAPT::Periodic::AutocleanInterval \"1\";\nAPT::Periodic::Unattended-Upgrade \"1\";" > /etc/apt/apt.conf.d/10periodic
    chmod 644 /etc/apt/apt.conf.d/10periodic
    echo "Daily update checks, download upgradeable packages, autoclean interval, and unattended upgrade enabled."
  fi
fi

apt autoclean
apt autoremove
