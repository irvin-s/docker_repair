FROM postgres

# run create.sql on init
COPY create.sql /docker-entrypoint-initdb.d
