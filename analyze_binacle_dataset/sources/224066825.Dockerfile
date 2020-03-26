FROM mysql:5.6

ENV MYSQL_DATABASE "todo"
ENV MYSQL_ALLOW_EMPTY_PASSWORD "yes"

COPY charset.cnf /etc/mysql/conf.d/
