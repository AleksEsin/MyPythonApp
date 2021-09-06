#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform with aws_eip and lifecycle!" > /var/www/html/index.html
sudo service apache2 restart
