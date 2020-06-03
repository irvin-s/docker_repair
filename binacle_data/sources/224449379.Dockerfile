FROM postgres:9.4

COPY postgresql.conf /postgresql.conf
COPY set-config.sh /docker-entrypoint-initdb.d/set-config.sh
