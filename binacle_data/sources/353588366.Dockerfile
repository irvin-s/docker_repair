FROM postgres:9.4

RUN apt-get update && apt-get install postgis -y
COPY 001-createdb.sh /docker-entrypoint-initdb.d/
COPY dump.sql.gz /
