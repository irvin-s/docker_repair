FROM postgres:9.3.5

COPY files/create_db.sh /docker-entrypoint-initdb.d/create_db.sh