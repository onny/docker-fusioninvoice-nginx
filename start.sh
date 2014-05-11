#!/bin/bash

#mysql has to be started this way as it doesn't work to call from /etc/init.d
/usr/bin/mysqld_safe & 
sleep 10s

# Here we generate random passwords (thank you pwgen!). The first two are for mysql users, the last batch for random keys in wp-config.php
FUSIONINVOICE_DB="fusioninvoice"
MYSQL_PASSWORD=`pwgen -c -n -1 12`
FUSIONINVOICE_PASSWORD=`pwgen -c -n -1 12`
#This is so the passwords show up in logs. 
echo mysql root password: $MYSQL_PASSWORD
echo fusioninvoice password: $FUSIONINVOICE_PASSWORD
echo $MYSQL_PASSWORD > /mysql-root-pw.txt
echo $FUSIONINVOICE_PASSWORD > /fusioninvoice-db-pw.txt

sed -i "s/root/fusioninvoice/" /usr/share/nginx/www/application/config/database.php
sed -i "s/= 'password/= '$FUSIONINVOICE_PASSWORD/" /usr/share/nginx/www/application/config/database.php

mysqladmin -u root password $MYSQL_PASSWORD
mysql -uroot -p$MYSQL_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE fusioninvoice; GRANT ALL PRIVILEGES ON fusioninvoice.* TO 'fusioninvoice'@'localhost' IDENTIFIED BY '$FUSIONINVOICE_PASSWORD'; FLUSH PRIVILEGES;"
killall mysqld

# start all the services
/usr/local/bin/supervisord -n
