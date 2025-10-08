'''
echo "Executing Script ..."
if [[ $EUID -ne 0 ]]; then #!=> confirms sudo access
  echo "This script must be run as root"
  echo "Please use sudo ./master.sh to run"
  exit
fi
'''
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

#Pass Aging
echo "Set password aging(/etc/login.defs)? (y|n)"
read -r  PSAGE

if [ "$PSAGE" = "y" ];then
    echo "setting passwords to reset after 30 days"
    PASSMAX="$(grep -n 'PASS_MAX_DAYS' /etc/login.defs | grep -v '#' | cut -f1 -d:)"
    sed -e "${PASSMAX}s/.*/PASS_MAX_DAYS	30/" /etc/login.defs > ${USER_HOME}/backup/temp1.txt
    PASSMIN="$(grep -n 'PASS_MIN_DAYS' /etc/login.defs | grep -v '#' | cut -f1 -d:)"
    sed -e "${PASSMIN}s/.*/PASS_MIN_DAYS	7/" /var/local/temp1.txt > ${USER_HOME}/backup/temp2.txt
    PASSWARN="$(grep -n 'PASS_WARN_AGE' /etc/login.defs | grep -v '#' | cut -f1 -d:)"
    sed -e "${PASSWARN}s/.*/PASS_WARN_AGE	7/" /var/local/temp2.txt > ${USER_HOME}/backup/temp3.txt
    mv /etc/login.defs ${USER_HOME}/backup/login.defs.old
    mv ${USER_HOME}/backup/temp3.txt /etc/login.defs
    rm ${USER_HOME}/backup/temp1.txt ~/Desktop/backup/temp2.txt
fi

