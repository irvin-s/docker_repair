FROM vipconsult/psql_client

ADD run_backup.sh /run_backup.sh

ENTRYPOINT /bin/bash /run_backup.sh