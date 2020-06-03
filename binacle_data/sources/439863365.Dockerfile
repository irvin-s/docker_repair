FROM mysql:8

ENV MYSQL_ROOT_PASSWORD adbcjtck

COPY setup.sql /docker-entrypoint-initdb.d/setup.sql