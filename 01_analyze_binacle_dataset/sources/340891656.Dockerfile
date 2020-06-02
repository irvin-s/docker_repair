FROM mysql:latest

ADD startup /etc/mysql/startup

RUN chown -R mysql:root /var/lib/mysql/

ARG MYSQL_DATABASE=nodedock
ARG MYSQL_ROOT_PASSWORD=root

ENV MYSQL_DATABASE=$MYSQL_DATABASE
ENV MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD

RUN sed -i 's/MYSQL_DATABASE/'$MYSQL_DATABASE'/g' /etc/mysql/startup

ADD my.cnf /etc/mysql/conf.d/my.cnf

CMD ["mysqld", "--init-file=/etc/mysql/startup"]

EXPOSE 3306
