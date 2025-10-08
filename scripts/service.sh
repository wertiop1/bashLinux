#!/bin/bash
'''
echo "Executing Script ..."
if [[ $EUID -ne 0 ]]; then #!=> confirms sudo access
  echo "This script must be run as root"
  echo "Please use sudo ./master.sh to run"
  exit
fi
'''
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

#SSH
echo "use SSH? (y|n)"
read -r SSH

if [ "$SSH" = "y" ]; then
    ufw allow ssh
    apt install openssh-server
    apt install openssh-client

    echo "Disable Root Login? (y|n)"
    read -r SET_ROOT_DISABLE_SSH
    if [ "$SET_ROOT_DISABLE_SSH" = "y" ]; then
        echo "disabling root login"
        #get the line number of the PermitRootLogin line
        PRL="$(grep -n 'PermitRootLogin' /etc/ssh/sshd_config | grep -v '#' | cut -f1 -d:)"
        sed -e "${PRL}s/.*/PermitRootLogin no/" /etc/ssh/sshd_config > ${USER_HOME}/backup/temp1.txt
        mv /etc/ssh/sshd_config ${USER_HOME}/backup/sshd_config-1.old
        mv ${USER_HOME}/backup/temp1.txt /etc/ssh/sshd_config
    fi
    echo "Enable Standard SSH security? (y|n)"
    read -r SEC_SSH

    if [ "$SEC_SSH" = "y" ]; then
        echo "disabling empty passwords"

        PRL="$(grep -n 'PermitEmptyPasswords' /etc/ssh/sshd_config | grep -v '#' | cut -f1 -d:)"
        sed -e "${PRL}s/.*/PermitEmptyPasswords no/" /etc/ssh/sshd_config > ${USER_HOME}/backup/temp1.txt
        mv /etc/ssh/sshd_config ${USER_HOME}/backup/sshd_config-2.old
        mv ${USER_HOME}/backup/temp1.txt /etc/ssh/sshd_config
        echo "disabling user environment"

        PRL="$(grep -n 'PermitUserEnvironment' /etc/ssh/sshd_config | grep -v '#' | cut -f1 -d:)"
        sed -e "${PRL}s/.*/PermitUserEnvironment no/" /etc/ssh/sshd_config > ${USER_HOME}/backup/temp1.txt
        mv /etc/ssh/sshd_config ${USER_HOME}/backup/sshd_config-3.old
        mv ${USER_HOME}/backup/temp1.txt /etc/ssh/sshd_config

        echo "disabling Host Based Authentication"

        PRL="$(grep -n 'HostbasedAuthentication' /etc/ssh/sshd_config | grep -v '#' | cut -f1 -d:)"
        sed -e "${PRL}s/.*/HostbasedAuthentication no/" /etc/ssh/sshd_config > ${USER_HOME}/backup/temp1.txt
        mv /etc/ssh/sshd_config ${USER_HOME}/backup/sshd_config-4.old
        mv ${USER_HOME}/backup/temp1.txt /etc/ssh/sshd_config

        echo "set Client Alive Interval to 300"

        PRL="$(grep -n 'ClientAliveInterval' /etc/ssh/sshd_config | grep -v '#' | cut -f1 -d:)"
        sed -e "${PRL}s/.*/ClientAliveInterval 300/" /etc/ssh/sshd_config > ${USER_HOME}/backup/temp1.txt
        mv /etc/ssh/sshd_config ${USER_HOME}/backup/sshd_config-5.old
        mv ${USER_HOME}/backup/temp1.txt /etc/ssh/sshd_config

        echo "set Client Alive Count Max to 0"

        PRL="$(grep -n 'ClientAliveCountMax' /etc/ssh/sshd_config | grep -v '#' | cut -f1 -d:)"
        sed -e "${PRL}s/.*/ClientAliveCountMax 0/" /etc/ssh/sshd_config > ${USER_HOME}/backup/temp1.txt
        mv /etc/ssh/sshd_config ${USER_HOME}/backup/sshd_config-6.old
        mv ${USER_HOME}/backup/temp1.txt /etc/ssh/sshd_config

        echo "Set Login Grace Time to 60"

        PRL="$(grep -n 'LoginGraceTime' /etc/ssh/sshd_config | grep -v '#' | cut -f1 -d:)"
        sed -e "${PRL}s/.*/LoginGraceTime 60/" /etc/ssh/sshd_config > ${USER_HOME}/backup/temp1.txt
        mv /etc/ssh/sshd_config ${USER_HOME}/backup/sshd_config-7.old
        mv ${USER_HOME}/backup/temp1.txt /etc/ssh/sshd_config

        echo "Set Banner location"

        PRL="$(grep -n 'Banner' /etc/ssh/sshd_config | grep -v '#' | cut -f1 -d:)"
        sed -e "${PRL}s/.*/Banner /etc/issue.net/" /etc/ssh/sshd_config > ${USER_HOME}/backup/temp1.txt
        mv /etc/ssh/sshd_config ${USER_HOME}/backup/sshd_config-8.old
        mv ${USER_HOME}/backup/temp1.txt /etc/ssh/sshd_config
    fi
    echo "Start SSH system? (y|n)"
    read -r START_SSH

    if [ "$START_SSH" = "y" ]; then
    
        systemctl start ssh
        systemctl restart ssh
        systemctl status ssh
    fi

else
    ufw deny ssh
	apt-get purge openssh-server -y -qq
    echo "SSH port has been denied on the firewall. Open-SSH has been removed."
fi

echo "Use Samba? (y|n)"
read sambaYN

if [ "$sambaYN" = "n" ]; then
	ufw deny netbios-ns
	ufw deny netbios-dgm
	ufw deny netbios-ssn
	ufw deny microsoft-ds
	apt-get purge samba -y -qq
	apt-get purge samba-common -y  -qq
	apt-get purge samba-common-bin -y -qq
	apt-get purge samba4 -y -qq
	clear
	echo "netbios-ns, netbios-dgm, netbios-ssn, and microsoft-ds ports have been denied. Samba has been removed."
elif [ "$sambaYN" = "y" ]; then
	ufw allow netbios-ns
	ufw allow netbios-dgm
	ufw allow netbios-ssn
	ufw allow microsoft-ds
	apt-get install samba -y -qq
	apt-get install system-config-samba -y -qq
	cp /etc/samba/smb.conf ${USER_HOME}/backup/
	if [ "$(grep '####### Authentication #######' /etc/samba/smb.conf)"==0 ]
	then
		sed -i 's/####### Authentication #######/####### Authentication #######\nsecurity = user/g' /etc/samba/smb.conf
	fi
	sed -i 's/usershare allow guests = no/usershare allow guests = yes/g' /etc/samba/smb.conf
	
	echo Type all user account names, with a space in between
	read -a usersSMB
	usersSMBLength=${#usersSMB[@]}	
	for (( i=0;i<$usersSMBLength;i++)); do
		echo -e 'Cyb3rP@tr!0ts\nCyb3rP@tr!0ts' | smbpasswd -a ${usersSMB[${i}]}
		echo "${usersSMB[${i}]} has been given the password 'Cyb3rP@tr!0ts' for Samba."
	done
	echo "netbios-ns, netbios-dgm, netbios-ssn, and microsoft-ds ports have been denied. Samba config file has been configured."
	clear
else
	echo Response not recognized.
fi
echo "Samba is complete."


echo "Use FTP? (y|n)"
read ftpYN

if [ "$ftpYN" = "n" ]; then
	ufw deny ftp 
	ufw deny sftp 
	ufw deny saft 
	ufw deny ftps-data 
	ufw deny ftps
	apt-get purge vsftpd -y -qq
	echo "vsFTPd has been removed. ftp, sftp, saft, ftps-data, and ftps ports have been denied on the firewall."
elif [ "$ftpYN" = "y" ]; then
	ufw allow ftp 
	ufw allow sftp 
	ufw allow saft 
	ufw allow ftps-data 
	ufw allow ftps
	cp /etc/vsftpd/vsftpd.conf ${USER_HOME}/backup/
	cp /etc/vsftpd.conf ${USER_HOME}/backup/
	gedit /etc/vsftpd/vsftpd.conf&gedit /etc/vsftpd.conf
	service vsftpd restart
	echo "ftp, sftp, saft, ftps-data, and ftps ports have been allowed on the firewall. vsFTPd service has been restarted."
else
	echo Response not recognized.
fi
echo "FTP is complete."

echo "Use Telnet (y|n)"
read telnetYN

if [ $telnetYN = "n" ]
then
	ufw deny telnet 
	ufw deny rtelnet 
	ufw deny telnets
	apt-get purge telnet -y -qq
	apt-get purge telnetd -y -qq
	apt-get purge inetutils-telnetd -y -qq
	apt-get purge telnetd-ssl -y -qq
	echo "Telnet port has been denied on the firewall and Telnet has been removed."
elif [ "$telnetYN" = "y" ]
then
	ufw allow telnet 
	ufw allow rtelnet 
	ufw allow telnets
	echo "Telnet port has been allowed on the firewall."
else
	echo Response not recognized.
fi
echo "Telnet is complete."

echo "Does this machine need Mail? (y|n)"
read mailYN

if [ "$mailYN" = "n" ]
then
	ufw deny smtp 
	ufw deny pop2 
	ufw deny pop3
	ufw deny imap2 
	ufw deny imaps 
	ufw deny pop3s
	echo "smtp, pop2, pop3, imap2, imaps, and pop3s ports have been denied on the firewall."
elif [ "$mailYN" = "y" ]
then
	ufw allow smtp 
	ufw allow pop2 
	ufw allow pop3
	ufw allow imap2 
	ufw allow imaps 
	ufw allow pop3s
	echo "smtp, pop2, pop3, imap2, imaps, and pop3s ports have been allowed on the firewall."
else
	echo Response not recognized.
fi
echo "Mail is complete."


echo "Does this machine need Printing? (y|n)"
read printYN

if [ "$printYN" = "n" ]
then
	ufw deny ipp 
	ufw deny printer 
	ufw deny cups
	echo "ipp, printer, and cups ports have been denied on the firewall."
elif [ "$printYN" = "y" ]
then
	ufw allow ipp 
	ufw allow printer 
	ufw allow cups
	echo "ipp, printer, and cups ports have been allowed on the firewall."
else
	echo Response not recognized.
fi
echo "Printing is complete."

echo "Use MySQL? (y|n)"
read dbYN

if [ $dbYN == "n" ]
then
	ufw deny ms-sql-s 
	ufw deny ms-sql-m 
	ufw deny mysql 
	ufw deny mysql-proxy
	apt-get purge mysql -y -qq
	apt-get purge mysql-client-core-5.5 -y -qq
	apt-get purge mysql-client-core-5.6 -y -qq
	apt-get purge mysql-common-5.5 -y -qq
	apt-get purge mysql-common-5.6 -y -qq
	apt-get purge mysql-server -y -qq
	apt-get purge mysql-server-5.5 -y -qq
	apt-get purge mysql-server-5.6 -y -qq
	apt-get purge mysql-client-5.5 -y -qq
	apt-get purge mysql-client-5.6 -y -qq
	apt-get purge mysql-server-core-5.6 -y -qq
	echo "ms-sql-s, ms-sql-m, mysql, and mysql-proxy ports have been denied on the firewall. MySQL has been removed."
elif [ "$dbYN" = "y" ]
then
	ufw allow ms-sql-s 
	ufw allow ms-sql-m 
	ufw allow mysql 
	ufw allow mysql-proxy
	apt-get install mysql-server-5.6 -y -qq
	cp /etc/my.cnf ${USER_HOME}/backup/
	cp /etc/mysql/my.cnf ${USER_HOME}/backup/
	cp /usr/etc/my.cnf ${USER_HOME}/backup/
	cp ~/.my.cnf ${USER_HOME}/backup/
	if grep -q "bind-address" "/etc/mysql/my.cnf"
	then
		sed -i "s/bind-address\t\t=.*/bind-address\t\t= 127.0.0.1/g" /etc/mysql/my.cnf
	fi
	gedit /etc/my.cnf&gedit /etc/mysql/my.cnf&gedit /usr/etc/my.cnf&gedit ~/.my.cnf
	service mysql restart
	echo "ms-sql-s, ms-sql-m, mysql, and mysql-proxy ports have been allowed on the firewall. MySQL has been installed. MySQL config file has been secured. MySQL service has been restarted."
else
	echo Response not recognized.
fi
echo "MySQL is complete."


echo "Will this machine be a Web Server? (y|n)"
read httpYN

if [ "$httpYN" = "n" ]
then
	ufw deny http
	ufw deny https
	apt-get purge apache2 -y -qq
	rm -r /var/www/*
	echo "http and https ports have been denied on the firewall. Apache2 has been removed. Web server files have been removed."
elif [ "$httpYN" = "y" ]
then
	apt-get install apache2 -y -qq
	ufw allow http 
	ufw allow https
	cp /etc/apache2/apache2.conf ${USER_HOME}/backup/
	if [ -e /etc/apache2/apache2.conf ]
	then
  	  echo -e '\<Directory \>\n\t AllowOverride None\n\t Order Deny,Allow\n\t Deny from all\n\<Directory \/\>\nUserDir disabled root' >> /etc/apache2/apache2.conf
	fi
	chown -R root:root /etc/apache2

	echo "http and https ports have been allowed on the firewall. Apache2 config file has been configured. Only root can now access the Apache2 folder."
else
	echo Response not recognized.
fi
echo "Web Server is complete."

echo Does this machine need DNS?
read dnsYN

if [ "$dnsYN" = "n" ]
then
	ufw deny domain
	apt-get purge bind9 -qq
	echo "domain port has been denied on the firewall. DNS name binding has been removed."
elif [ "$dnsYN" = "y" ]
then
	ufw allow domain
	echo "domain port has been allowed on the firewall."
else
	echo Response not recognized.
fi
echo "DNS is complete."

