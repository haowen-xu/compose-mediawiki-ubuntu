#!/bin/bash
mkdir -p ./backup
docker-compose exec db /bin/bash -c 'mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD" 2>/dev/null | gzip | base64 -w 0' | base64 -d > backup/backup_$(date +"%Y%m%d_%H%M%S").sql.gz
docker-compose exec web /bin/bash -c 'tar -c $MW_VOLUME $MW_HOME/images 2>/dev/null | base64 -w 0' | base64 -d > backup/backup_$(date +"%Y%m%d_%H%M%S").tar
