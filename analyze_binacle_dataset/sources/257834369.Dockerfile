FROM onjin/alpine-postgres:9.5

# files are processed in ASCII order
COPY ./init/01-db_setup.sh /docker-entrypoint-initdb.d/01-db-setup.sh
