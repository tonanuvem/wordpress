# docker exec <backup-container-name> restore <date>
# <date>: The timestamp of the backup to restore, in the format yyyyMMdd.

docker exec dinamica_backup_1 tar -xvf backup.tar --directory /backups/
docker exec dinamica_backup_1 restore 20200425

SERVER_IP=$(curl checkip.amazonaws.com)
echo $SERVER_IP

# update wp-config.php
docker exec dinamica_backup_1 cat /var/www/html/wp-config.php | grep DB_HOST
docker exec dinamica_backup_1 sed -i s/"define( 'DB_HOST', '.*');"/"define( 'DB_HOST', 'mysql:3306');"/g /var/www/html/wp-config.php
docker exec dinamica_backup_1 cat /var/www/html/wp-config.php | grep DB_HOST

# https://wordpress.org/support/article/changing-the-site-url/#edit-functions-php
# update wp-content/themes/twentyseventeen/functions.php
docker exec dinamica_backup_1 cat /var/www/html/wp-content/themes/twentyseventeen/functions.php | grep update_option
# //update_option( 'siteurl', 'http://54.165.165.218' );
# //update_option( 'home', 'http://54.165.165.218' );

# TO DO
docker exec dinamica_backup_1 sed -i 's|//update_option( 'siteurl',.*|update_option( 'siteurl', '$(curl checkip.amazonaws.com)' );|' /var/www/html/wp-content/themes/twentyseventeen/functions.php
docker exec dinamica_backup_1 sed -i s|"//update_option( 'siteurl', '.*' );"|"//update_option( 'siteurl', '$SERVER_IP' );"|g /var/www/html/wp-content/themes/twentyseventeen/functions.php
docker exec dinamica_backup_1 sed 's_//update_option( 'siteurl', 'http://54.165.165.218' );_//update_option( 'siteurl', '$SERVER_IP' );_' /var/www/html/wp-content/themes/twentyseventeen/functions.php

docker exec dinamica_backup_1 cat /var/www/html/wp-content/themes/twentyseventeen/functions.php | grep update_option
#update_option( 'siteurl', '$(curl checkip.amazonaws.com)' );
#update_option( 'home', '$(curl checkip.amazonaws.com)' );
