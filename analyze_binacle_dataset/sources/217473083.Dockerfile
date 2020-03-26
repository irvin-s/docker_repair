FROM postgres
MAINTAINER vigliag@gmail.com

COPY ./init_db.sql /docker-entrypoint-initdb.d
