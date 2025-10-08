echo "Executing Permission Script ..."
if [[ $EUID -ne 0 ]] #!=> confirms sudo access
then
  echo "This script must be run as root"
  echo "Please use sudo ./permissions.sh to run"
  exit
fi

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)


#seting permissions for shadow and gshadow files
echo "Change Shadow and Gshadow file permissions? (y|n)"
read -r SHADOW

if [[ "$SHADOW" == "y" ]]; then
    chmod 640 /etc/shadow
    chmod 640 /etc/gshadow
    echo "Gshadow and Shadow file permisions have been set"
fi

echo "Creating Log for Higher Permission Files in ~/log/higherPermFiles.log"
echo "Logging Files"
for i in {0..7};
do
  for j in {0..7};
  do
    value=700+$j*10+$i
    find / -type f -perm 777 >> $(USER_HOME)/log/higherPermFiles.log
  done
done
echo "Logged Files"
