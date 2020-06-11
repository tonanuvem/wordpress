# docker exec <backup-container-name> restore <date>
# <date>: The timestamp of the backup to restore, in the format yyyyMMdd.

docker exec dinamica_backup_1 restore 20200425

SERVER_IP=$(curl checkip.amazonaws.com)
echo $SERVER_IP

# update wp-config.php
sed -i s/"define('DB_NAME', '.*');"/"define('DB_NAME', '$MYSQL_ENV_MYSQL_DATABASE');"/g /var/www/html/wp-config.php

sed -i 's|define( 'DB_HOST',.*|define( 'DB_HOST', 'mysql:3306');|' /var/www/html/wp-config.php
define( 'DB_HOST', 'db:3306');|define( 'DB_HOST', 'mysql:3306');
define( 'DB_HOST', 'db:3306');|#define( 'DB_HOST', 'db:3306');

# update wp-content/themes/twentyseventeen/functions.php
sed -i s/"define('DB_NAME', '.*');"/"define('DB_NAME', '$MYSQL_ENV_MYSQL_DATABASE');"/g /var/www/html/wp-config.php

sed -i 's|#update_option( 'siteurl'*|ServerActive='$SERVER_IP'|' ~/environment/zabbix_agent/conf/zabbix_agentd.conf


sed -i 's|ServerActive=.*|ServerActive='$SERVER_IP'|' ~/environment/zabbix_agent/conf/zabbix_agentd.conf

update_option( 'siteurl', 'http://ip172-18-0-6-brgnjn5im9m000cu8kgg-8000.direct.labs.play-with-docker.com/' );
update_option( 'home', 'http://ip172-18-0-6-brgnjn5im9m000cu8kgg-8000.direct.labs.play-with-docker.com/' );
