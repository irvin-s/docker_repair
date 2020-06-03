FROM mariadb

LABEL maintainer="Scott Came (scottcame10@gmail.com)" \
  org.label-schema.description="Image with MariaDB instance containing demo data for Shiny demo" \
  org.label-schema.vcs-url="https://github.com/scottcame/shiny-microservice-demo/docker/demo-mariadb"

ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes

COPY files/* /docker-entrypoint-initdb.d/
