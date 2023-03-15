#!/bin/bash
#use this for user data (script from top to bottom)
#install httpd (Linux 2 version)
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl start httpd
echo "madhan webserver from $(hostname)" > /var/www/html/index.html
