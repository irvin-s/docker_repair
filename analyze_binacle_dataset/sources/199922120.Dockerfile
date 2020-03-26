FROM mysql:5

ENV MYSQL_ROOT_PASSWORD=reliable

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
