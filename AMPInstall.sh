#!/usr/bin/env bash
#Author: Roei Kessler D-Alloc
#Date: 28-04-18
#Description: Script that will install the following: Web Service, SQL Service and Scripting language
############  After installing service a webpage will be created with personal customization
#Version: 1.0.1
sqlSer=0
webSer=0
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

while [ $webSer -ne 1 ]
do
echo "Installing Web Service"
echo "--------------------------------------"
echo "Please Select One Of The Option Below:"
echo "1) Apache"
echo "2) Ngnix"
echo "3) Go To SQL Installation"
read webservice

case $webservice in
	1)
		$package install httpd -y
	;;
	2)
		$package install epel-release -y
                $package install ngnix -y
	;;
	3)
		echo "Now We Will Install SQL Service"
		((webSer++))
	;;
	*)
		echo "Incorrect Input Please Try Again"
	;;
	esac

done

#Installing SQL Service
#Variable 'sqlservice' holds user input	for which service he wants to install

while [ $sqlSer -ne 1 ]
do
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

case $sqlservice in
	1)
		wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
                sudo rpm -ivh mysql57-community-release-el7-9.noarch.rpm
                $package update -y
                $package install mysql-server -y
	;;
	2)
		$package install mariadb -y
	;;
	3)
		$package install sqlite -y
	;;
	4)
		$package install postgresql -y
	;;
	5)
		$package install mongodb -y
	;;
	6)
		echo "Now We Will Install Scripting Language"
                ((sqlSer++))
	;;
	*)
		echo "Incorrect Input Please try again"
	;;
	esac

done
