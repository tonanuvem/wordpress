# https://github.com/angelo-v/wordpress-backup
# docker exec <backup-container-name> backup
docker exec dinamica_backup_1 backup
# https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes
docker run --rm --volumes-from dinamica_backup_1 -v $(pwd):/backup tonanuvem/wordpress-backup tar cvf /backup/backup.tar /backups
sudo docker build -t wordpress-backup .
TAG=$(date '+%Y%m%d_%H%M')
echo "TAG = $TAG"
docker login
docker tag wordpress-backup:latest tonanuvem/wordpress-backup:$TAG
docker push tonanuvem/wordpress-backup:$TAG
