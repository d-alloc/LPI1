#!/usr/bin/env bash
#Author: Roei Kessler D-Alloc
#Date: 28-04-18
#Description: Script that will install the following: Web Service, SQL Service and Scripting language
############  After installing service a webpage will be created with personal customization
#Version: 1.0

#Check The OS Distrebution
#Variable 'os' saves the output of the cat which returns the OS
#Variable 'package' hold the command that will be required later to install a package (apt-get, yum, zypper etc..)
#In case OS isn't recognized below program will exit

os="$(sudo cat /etc/*-release | grep PRETTY_NAME | awk '{print$1}' | cut -c 14-)"
echo $os
if [ $os == 'CentOS' ]
	then
	package="yum"
	echo $package > /tmp/ampinstall.log
	$package install wget -y
	elif [ $os == 'openSUSE' ]
                then
                package="zypper"
                echo $package > /tmp/ampinstall.log
	else
	echo 'System Is Not Supported For This Script'
	echo 'Script Doesn't Support This OS At This Time >> /tmp/ampinstall.log
	exit 1
fi

#Installing Web Service
#Variable 'webservice' holds user input for which service he wants to install

echo "Installing Web Service"
echo "--------------------------------------"
echo "Please Select One Of The Option Below:"
echo "1) Apache"
echo "2) Ngnix"
echo "3) Go To SQL Installation"
read webservice

if [ $webservice == 1 ]
	then
	$package install httpd -y
elif [ $webservice == 2 ]
			then
			$package install epel-release -y
			$package install ngnix -y
elif [ $webservice == 3 ]
			then
			echo "Now We Will Install SQL Service"
else
			echo "Incorrect Input Please try again"
fi

#Installing SQL Service
#Variable 'sqlservice' holds user input	for which service he wants to install

echo "Installing SQL Service"
echo "--------------------------------------"
echo "Please Select One Of The Option Below:"
echo "1) MySql"
echo "2) MariaDB"
echo "3) sqLite"
echo "4) postgresql"
echo "5) mongoDB"
echo "6) Go To Scripting Language Installation"
read sqlservice

if [ $sqlservice == 1 ]
        then
				wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
        sudo rpm -ivh mysql57-community-release-el7-9.noarch.rpm
        $package update -y
        $package install mysql-server -y
elif [ $sqlservice == 2 ]
        then
				$package install mariadb -y
elif [ $sqlservice == 3 ]
        then
				$package install sqlite -y
elif [ $sqlservice == 4 ]
        then
				$package install postgresql -y
elif [ $sqlservice == 5 ]
        then
				$package install mongodb -y
elif [ $sqlservice == 6?ce == 6 ]
        then
				echo "Now We Will Install Scripting Language"
else
    		echo "Incorrect Input Please try again"
fi
