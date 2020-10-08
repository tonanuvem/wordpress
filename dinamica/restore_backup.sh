# docker exec <backup-container-name> restore <date>
# <date>: The timestamp of the backup to restore, in the format yyyyMMdd.

printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tAplicando o Restore:\n\n"

docker exec dinamica_backup_1 tar --strip-components=1 -xvf backup.tar
docker exec dinamica_backup_1 restore 20201008

SERVER_IP=$(curl checkip.amazonaws.com)
echo $SERVER_IP

printf "\n\n xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
printf "\n\n\tAjustando IP Externo do Site:\n\n"
printf "\n\tConfig antes:\n"
docker exec dinamica_wordpress_1 cat /var/www/html/wp-content/themes/twentyseventeen/functions.php | grep update_option

# Ajustar update_option
OLD_IP="54.160.86.98"
docker exec dinamica_wordpress_1 sed -i "s|$OLD_IP|$SERVER_IP|" /var/www/html/wp-content/themes/twentyseventeen/functions.php
docker exec dinamica_wordpress_1 curl localhost/wp-admin/

printf "\n\tConfig depois:\n"
docker exec dinamica_wordpress_1 cat /var/www/html/wp-content/themes/twentyseventeen/functions.php | grep update_option
curl http://$SERVER_IP/wp-admin/

printf "\n\tAcessar: http://$SERVER_IP"
printf "\n\n"
