FROM aveltens/wordpress-backup
COPY ./backup.tar /backups
WORKDIR /backups
RUN tar -xf backup.tar
