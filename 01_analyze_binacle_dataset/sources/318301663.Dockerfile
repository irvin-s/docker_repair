FROM microsoft/mssql-server-linux:latest

ARG target=/usr/share/wwi-db-setup
ARG source=./SqlScripts

RUN mkdir -p $target

COPY $source $target

RUN chmod +x $target/init-and-restore-db.sh