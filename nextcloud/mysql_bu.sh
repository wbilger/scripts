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

echo "Backing up Nextcloud database..."
mysqldump --single-transaction -h localhost -u nextcloud -pbd778cc928e90dcd08aadf2cff3d1b2c nextcloud > /home/wayne/nextcloud-sqlbkp_`date +"%Y%m%d"`.bak
echo "Done" echo

# Turn off Maintenance Mode

echo "Turning off maintenance mode for Nextcloud..."
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off
echo "Done"
echo
#!/bin/bash
