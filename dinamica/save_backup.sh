# https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes
docker run --rm --volumes-from backup -v $(pwd):/backup tonanuvem/wordpress-backup tar cvf /backup/backup.tar /backups
sudo docker build -t wordpress-backup .
docker login
docker tag wordpress-backup:latest tonanuvem/wordpress-backup
docker push tonanuvem/wordpress-backup
