# docker exec <backup-container-name> restore <date>
# <date>: The timestamp of the backup to restore, in the format yyyyMMdd.

printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tAplicando o Restore:\n\n"

docker exec dinamica_backup_1 tar -xvf backup.tar --directory /backups/
docker exec dinamica_backup_1 restore 20200425

SERVER_IP=$(curl checkip.amazonaws.com)
echo $SERVER_IP

#printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
#printf "\n\n\tAjustando config do Banco de Dados:\n\n"
# update wp-config.php - dont need
#printf "\n\tConfig antes:\n"
#docker exec dinamica_wordpress_1 cat /var/www/html/wp-config.php | grep DB_HOST
#docker exec dinamica_wordpress_1 sed -i s/"define( 'DB_HOST', '.*');"/"define( 'DB_HOST', 'mysql:3306');"/g /var/www/html/wp-config.php
#printf "\n\tConfig depois:\n"
#docker exec dinamica_wordpress_1 cat /var/www/html/wp-config.php | grep DB_HOST

printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tAjustando IP Externo do Site:\n\n"

# https://wordpress.org/support/article/changing-the-site-url/
# https://wordpress.org/support/article/changing-the-site-url/#edit-functions-php
# update wp-content/themes/twentyseventeen/functions.php
printf "\n\tConfig antes:\n"
docker exec dinamica_wordpress_1 cat /var/www/html/wp-content/themes/twentyseventeen/functions.php | grep update_option
# //update_option( 'siteurl', 'http://54.165.165.218' );
# //update_option( 'home', 'http://54.165.165.218' );

# TO DO - usa o volume /backups compartilhado
#docker exec dinamica_wordpress_1 echo sed -i "'s|54.165.165.218|'$SERVER_IP'|'" /var/www/html/wp-content/themes/twentyseventeen/functions.php
#docker exec dinamica_wordpress_1 echo sed -i "'s|54.165.165.218|'$SERVER_IP'|'" /var/www/html/wp-content/themes/twentyseventeen/functions.php >> ./backups/update_option.sh
#docker exec dinamica_wordpress_1 echo sed -i "'s|//update_option|update_option|'" /var/www/html/wp-content/themes/twentyseventeen/functions.php >> ~/update_option.sh
echo sed -i "'s|54.165.165.218|'$SERVER_IP'|'" /var/www/html/wp-content/themes/twentyseventeen/functions.php > ./backups/update_option.sh
echo sed -i "'s|//update_option|update_option|'" /var/www/html/wp-content/themes/twentyseventeen/functions.php >> ./backups/update_option.sh
docker exec dinamica_wordpress_1 sh /backups/update_option.sh
docker exec dinamica_wordpress_1 curl localhost/wp-admin/

printf "\n\tConfig depois:\n"
docker exec dinamica_wordpress_1 cat /var/www/html/wp-content/themes/twentyseventeen/functions.php | grep update_option
#update_option( 'siteurl', '$(curl checkip.amazonaws.com)' );
#update_option( 'home', '$(curl checkip.amazonaws.com)' );

printf "\n\tAcessar: http://$SERVER_IP/wp-admin/"
curl http://$SERVER_IP/wp-admin/
printf "\n\n"
