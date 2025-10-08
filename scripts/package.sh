echo "Executing Package Script ..."
if [[ $EUID -ne 0 ]]; then #!=> confirms sudo access
  echo "This script must be run as root"
  echo "Please use sudo ./package.sh to run"
  exit
fi

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)


echo "Package Audit? (y|n)"
read -r PACKAGE

if [[ "$PACKAGE" == "y" ]]; then
    
    echo "Saftey? (y|n)"
    read -r SAFE
    if [[ "$SAFE" == y ]]; then
    #netcat
        echo "Remove NetCat? (y|n)"
        read -r NC
        if [[ "$NC" == "y" ]]; then
            apt purge netcat -y -qq
            apt purge netcat-openbsd -y -qq
            apt purge netcat-traditional -y -qq
            apt purge ncat -y -qq
            apt purge pnetcat -y -qq
            apt purge socat -y -qq
            apt purge sock -y -qq
            apt purge socket -y -qq
            apt purge sbd -y -qq
            rm /usr/bin/nc

            echo "Netcat and all other instances have been removed"
        fi

    #John the Ripper
        echo "Removed John the Ripper? (y|n)"
        read -r RIPPER

        if [[ "$RIPPER" == "y" ]]; then
            apt purge john -y -qq
            apt purge john-data -y -qq
            echo "John the Ripper has been removed."
        fi


        echo "Remove Hydra? (y|n)"
        read -r HYDRA
        
        if [[ "$HYDRA" == "y" ]]; then
            apt purge hydra -y -qq
            apt purge hydra-gtk -y -qq
            echo "Hydra has been removed."
        fi

        echo "Remove NMAP? (y|n)"
        read -r NMAP

        if [[ "$NMAP" == "y" ]]; then
            apt purge nmap -y -qq
            echo "Nmap has been removed"
        fi

        echo "Remove Aircrack? (y|n)"
        read -r AIRCRACK
        if [[ "$AIRCRACK" == "y" ]]; then
            apt purge aircrack-ng -y -qq
            echo "Aircrack-NG has been removed."
        fi

        echo "Remove FCrackZIP? (y|n)"
        read -r ZIP
        if [[ "$ZIP" == "y" ]]; then
            apt purge fcrackzip -y -qq
            echo "FCrackZIP has been removed."
        fi

        echo "Remove OPHCrack? (y|n)"
        read -r OPHCRACK
        if [[ "$OPHCRACK" == "y" ]]; then
            apt purge ophcrack -y -qq
            apt purge ophcrack-cli -y -qq
            echo "OphCrack has been removed."
        fi

        echo "Remove PDFCrack? (y|n)"
        read -r PDFCRACK
        if [[ "$PDFCRACK" == "y" ]]; then
            apt purge pdfcrack -y -qq
            echo "PDFCrack has been removed." 
        fi

        echo "Remove pyrit? (y|n)"
        read -r PYRIT
        if [[ "$PYRIT" == "y" ]]; then
            apt purge pyrit
            echo "pyrit removed"
        fi

        echo "Remove Rarcrack? (y|n)"
        read -r RARcrack
        if [[ "$RARcrack" == "y" ]]; then
            apt purge rarcrack -y -qq
            echo "RARcrack has been removed"
        fi

        echo "Remove sipcrack? (y|n)"
        read -r SIPCRACK

        if [[ "$SIPCRACK" == "y" ]]; then
            apt purge sipcrack -y -qq
            echo "SipCrack removed"
        fi

        echo "Remove IRPAS? (y|n)"
        read -r IRPAS
        if [[ "$IRPAS" == "y" ]]; then
            apt purge orpas -y -qq
            echo "IRPAS removed"
        fi

        echo "Remove LogKeys? (y|n)"
        read -r LOGKEYS
        if [[ "$LOGKEYS" == "y" ]]; then
            apt purge logkeys -y -qq
            echo "LogKeys removed"
        fi

        echo "Remove Zeitgeist? (y|n)"
        read -r Zeitgeist
        if [[ "$Zeitgeist" == "y" ]]; then
            apt purge zeitgeist-core -y -qq
            apt purge zeitgeist-datahub -y -qq
            apt purge python-zeitgeist -y -qq
            apt purge rhythmbox-plugin-zeitgeist -y -qq
            apt purge zeitgeist -y -qq
            echo "Zeitgeist has been removed."
        fi

        echo "Remove NFS? (y|n)"
        read -r NFS
        if [[ "$NFS" == "y" ]]; then
            apt purge nfs-kernel-server -y -qq
            apt purge nfs-common -y -qq
            apt purge portmap -y -qq
            apt purge rpcbind -y -qq
            apt purge autofs -y -qq
            echo "NFS has been removed."
        fi

        echo "Remove NGINX? (y|n)"
        read -r NGINX
        if [[ "$NGINX" == "y" ]]; then
            apt purge nginx -y -qq
            apt purge nginx-common -y -qq
            echo "NGINX has been removed."
        fi

        echo "Remove Inetd (super-server/ internet daemon) and inet utilities? (y|n)"
        read -r Inetd
        if [[ "$Inetd" == "y" ]]; then 
            pt-get purge inetd -y -qq
            apt purge openbsd-inetd -y -qq
            apt purge xinetd -y -qq
            apt purge inetutils-ftp -y -qq
            apt purge inetutils-ftpd -y -qq
            apt purge inetutils-inetd -y -qq
            apt purge inetutils-ping -y -qq
            apt purge inetutils-syslogd -y -qq
            apt purge inetutils-talk -y -qq
            apt purge inetutils-talkd -y -qq
            apt purge inetutils-telnet -y -qq
            apt purge inetutils-telnetd -y -qq
            apt purge inetutils-tools -y -qq
            apt purge inetutils-traceroute -y -qq
            echo "Inetd (super-server) and all inet utilities have been removed."
        fi

        echo "Remove VNC? (y|n)"
        read -r VNC
        if [[ "$VNC" == "y" ]]; then
            apt purge vnc4server -y -qq
            apt purge vncsnapshot -y -qq
            apt purge vtgrab -y -qq
            echo "VNC has been removed."
        fi

        echo "Remove SNMP? (y|n)"
        read -r SNMP
        if [[ "$SNMP" == "y" ]]; then
            apt purge snmp -y -qq
            echo "SNMP has been removed."
        fi

        echo "Remove Wireshark? (y|n)"
        read -r WS
        if [[ "$WS" == "y" ]]; then
            apt purge wireshark -y -qq
            echo "Wireshark has been removed"
        fi

        apt autoremove
    
    elif [[ "$SAFE" == "n" ]]; then
        apt purge netcat -y -qq
        apt purge netcat-openbsd -y -qq
        apt purge netcat-traditional -y -qq
        apt purge ncat -y -qq
        apt purge pnetcat -y -qq
        apt purge socat -y -qq
        apt purge sock -y -qq
        apt purge socket -y -qq
        apt purge sbd -y -qq
        rm /usr/bin/nc

        echo "Netcat and all other instances have been removed."

        apt purge john -y -qq
        apt purge john-data -y -qq

        echo "John the Ripper has been removed."

        apt purge hydra -y -qq
        apt purge hydra-gtk -y -qq

        echo "Hydra has been removed."

        apt purge nmap -y -qq

        echo "Nmap has been removed"

        apt purge aircrack-ng -y -qq

        echo "Aircrack-NG has been removed."

        apt purge fcrackzip -y -qq

        echo "FCrackZIP has been removed."

        apt purge lcrack -y -qq

        echo "LCrack has been removed."

        apt purge ophcrack -y -qq
        apt purge ophcrack-cli -y -qq

        echo "OphCrack has been removed."

        apt purge pdfcrack -y -qq

        echo "PDFCrack has been removed."

        apt purge pyrit -y -qq

        echo "Pyrit has been removed."

        apt purge rarcrack -y -qq

        echo "RARCrack has been removed."

        apt purge sipcrack -y -qq

        echo "SipCrack has been removed."

        apt purge irpas -y -qq

        echo "IRPAS has been removed."


        echo 'Are there any hacking tools shown? (not counting libcrack2:amd64 or cracklib-runtime)'
        dpkg -l | egrep "crack|hack" >> ~/Desktop/Script.log

        apt purge logkeys -y -qq
        
        echo "LogKeys has been removed."

        apt purge zeitgeist-core -y -qq
        apt purge zeitgeist-datahub -y -qq
        apt purge python-zeitgeist -y -qq
        apt purge rhythmbox-plugin-zeitgeist -y -qq
        apt purge zeitgeist -y -qq
        echo "Zeitgeist has been removed."

        apt purge nfs-kernel-server -y -qq
        apt purge nfs-common -y -qq
        apt purge portmap -y -qq
        apt purge rpcbind -y -qq
        apt purge autofs -y -qq
        echo "NFS has been removed."

        apt purge nginx -y -qq
        apt purge nginx-common -y -qq
        echo "NGINX has been removed."

        apt purge inetd -y -qq
        apt purge openbsd-inetd -y -qq
        apt purge xinetd -y -qq
        apt purge inetutils-ftp -y -qq
        apt purge inetutils-ftpd -y -qq
        apt purge inetutils-inetd -y -qq
        apt purge inetutils-ping -y -qq
        apt purge inetutils-syslogd -y -qq
        apt purge inetutils-talk -y -qq
        apt purge inetutils-talkd -y -qq
        apt purge inetutils-telnet -y -qq
        apt purge inetutils-telnetd -y -qq
        apt purge inetutils-tools -y -qq
        apt purge inetutils-traceroute -y -qq
        echo "Inetd (super-server) and all inet utilities have been removed."


        apt purge vnc4server -y -qq
        apt purge vncsnapshot -y -qq
        apt purge vtgrab -y -qq
        echo "VNC has been removed."


        apt purge snmp -y -qq
        echo "SNMP has been removed."


        apt purge wireshark -y -qq
        echo "Wireshark has been removed"

        apt autoremove
    else 
        echo "Misinput"
        #./package.sh
    fi
fi




