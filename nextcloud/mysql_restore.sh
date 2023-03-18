#!/bin/bash

#### Nextcloud Backup

# Turn on Maintenance Mode

echo "Turning on maintenance mode for Nextcloud..."
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --on
echo "Done"
echo
read -p  "Ensure maintenance mode is on and press [Enter] to continue..."
echo

# Backup DB

# Backup DB
echo "Deleting Nextcloud database, recreating, and restoring backup..."
mysql -h localhost -u nextcloud -pbd778cc928e90dcd08aadf2cff3d1b2c -e "DROP DATABASE nextcloud"
mysql -h localhost -u nextcloud -pbd778cc928e90dcd08aadf2cff3d1b2c -e "CREATE DATABASE nextcloud"
mysql -h localhost -u nextcloud -pbd778cc928e90dcd08aadf2cff3d1b2c nextcloud < /home/wayne/nextclouddb.bak
echo "Done"
echo
# Turn off Maintenance Mode

echo "Turning off maintenance mode for Nextcloud..."
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off
echo "Done"
echo
