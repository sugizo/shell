#!/bin/sh

echo "Enable Networking"
ifconfig eth0 up

echo "Update Packages"
apt update

echo "Install Packages"
apt install -y apache2 mysql-server mysql-client php5 php5-mysql unzip vim wget

echo "Clean Packages"
apt clean all

echo "Update DB"
updatedb

echo "Backup and Edit MySQL Configuration File To Enable Access From The Other Computer"
cp /etc/mysql/my.cnf /tmp/
sed -i 's/bind-address/#bind-address/g' /etc/mysql/my.cnf

echo "Backup and Edit PHP Configuration File"
cp /etc/php5/apache2/php.ini /tmp/
sed -i 's/memory_limit = 128M/memory_limit = 256M/g' /etc/php5/apache2/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 64M/g' /etc/php5/apache2/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 64M/g' /etc/php5/apache2/php.ini
sed -i 's/;date.timezone =/date.timezone = Asia\/Jakarta/g' /etc/php5/apache2/php.ini
sed -i 's/expose_php = On/expose_php = Off/g' /etc/php5/apache2/php.ini
echo extension=mysql.so >> /etc/php5/apache2/php.ini

echo "Backup and Edit Apache Configuration"
cp /etc/apache2/apache2.conf /tmp/
echo ServerAdmin sugizo@linux.vmw >> /etc/apache2/apache2.conf
echo ServerName $HOSTNAME >> /etc/apache2/apache2.conf

echo "Restart Apache Service"
service mysql restart
service apache2 restart

