FROM postgres:9.4.4
ADD create.sh /docker-entrypoint-initdb.d/
