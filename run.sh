#!/bin/bash

echo "Preparing environment..."
echo "export CONTAINER_IP=$(ifconfig eth0 | grep inet | awk '{print $2}')" >> ~/.bashrc
source ~/.bashrc
echo "OK"

echo "Fixing PHP configuration..."
sed -i 's/;clear_env/clear_env/g' /etc/php-fpm.d/www.conf
echo "OK"

echo "Starting PHP"
php-fpm
echo "OK"

echo "Starting httpd..."
/usr/sbin/httpd -D FOREGROUND
