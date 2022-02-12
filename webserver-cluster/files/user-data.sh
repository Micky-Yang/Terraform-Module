#! /bin/bash
sudo yum update all -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo `hostname` > /var/www/html/index.html