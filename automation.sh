#!/bin/bash

#check define required variables in script

s3_bucket="upgrad-hitesh"
myname="hiteshgoad"
timestamp=$(date '+%d%m%Y-%H%M%S')

#check to update the packages at the start of script
apt update -y

#check if apache is already installed or not
dpkg -l apache2 >/dev/null 2>&1

if [ $? -eq 0 ]; then
	echo "continue without installation"
else
	apt install apache2 -y
fi

#check if apache is running fine or not

status=`systemctl is-active apache2`
if [ $status == "active" ] ;then
	echo "apache service is running fine"
else
	systemctl start apache2
fi

#check if the apache service is enabled for start at system boot

enable_state=`systemctl is-enabled apache2`
if [ $enable_state == "enable" ]; then
	echo "apache service is enabled to run at system restart"
else
	systemctl enable apache2
fi

#check create a tar file for error and access logs of apache in /var/log/apache2 dir

tar -cf /tmp/${myname}-httpd-logs-${timestamp}.tar /var/log/apache2/*log

#check upload tar to aws s3 bucket for backup
aws s3 cp /tmp/${myname}-httpd-logs-${timestamp}.tar s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
