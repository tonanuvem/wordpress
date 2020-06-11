# docker exec <backup-container-name> restore <date>
# <date>: The timestamp of the backup to restore, in the format yyyyMMdd.

docker exec dinamica_backup_1 tar -xvf backup.tar --directory /backups/
docker exec dinamica_backup_1 restore 20200425

# update wp-config.php
docker exec dinamica_backup_1 cat /var/www/html/wp-config.php | grep DB_HOST
#sed -i s/"define('DB_NAME', '.*');"/"define('DB_NAME', '$MYSQL_ENV_MYSQL_DATABASE');"/g /var/www/html/wp-config.php
docker exec dinamica_backup_1 sed -i s/"define( 'DB_HOST', '.*');"/"define('DB_HOST', '$mysql:3306');"/g /var/www/html/wp-config.php
docker exec dinamica_backup_1 cat /var/www/html/wp-config.php | grep DB_HOST

# update wp-content/themes/twentyseventeen/functions.php

docker exec dinamica_backup_1 cat /var/www/html/wp-content/themes/twentyseventeen/functions.php | grep update_option

sed -i 's|#update_option( 'siteurl'*|ServerActive='$SERVER_IP'|' ~/environment/zabbix_agent/conf/zabbix_agentd.conf


sed -i 's|ServerActive=.*|ServerActive='$SERVER_IP'|' ~/environment/zabbix_agent/conf/zabbix_agentd.conf

update_option( 'siteurl', '$(curl checkip.amazonaws.com)' );
update_option( 'home', '$(curl checkip.amazonaws.com)' );
