# Automation_Project
This script automation.sh is a bash script which does below things
1) check and update packages 
2) check for apache package installed or not
3) Install apachec package if not installed already.
4) check for apache service status active and enabled.
5) if not active or enabled it will enable and active it.
6) creates tar ball of all the log files under /var/log/apache2/ NOTE: only log files both error and access.
7) upload that tar ball to s3 bucket.
8) Script then checks for inventory.html in /var/www/html dir
9) if not present it will create one
10) script will also update the inventory.html with the uploaded log files details of already present.
11) script then check the cron job for executing this script automaticaly if not present it will create one.
