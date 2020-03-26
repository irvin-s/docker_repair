FROM postgres:11.1
ADD config.sh /docker-entrypoint-initdb.d/
