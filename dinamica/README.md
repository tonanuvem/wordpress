Criar a máquina virtual para hospedar a solução:

> cd config-ubuntu/vm-fiap

> sh iniciar.sh

> sh conectar.sh

Passo a passo:

> git clone https://github.com/tonanuvem/wordpress.git

> cd wordpress/dinamica

> docker-compose up -d

> chmod +x restore_backup.sh

> ./restore_backup.sh
