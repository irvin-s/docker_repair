FROM ubuntu

RUN apt-get update
#RUN apt-get upgrade
RUN apt-get install -y mysql-server && /usr/bin/mysql_install_db

RUN /usr/bin/mysqld_safe & \
  while ! mysqladmin ping 2>/dev/null ; do sleep 1; done && \
  mysqladmin create '@DB_DATABASE@' && \
  mysql --execute="GRANT ALL ON \`@DB_DATABASE@\`.* TO \`@DB_USER@\`@\`%\` IDENTIFIED BY '@DB_PASSWORD@'" && \
  sed -i -e "s/^bind-address/#&/" /etc/mysql/my.cnf
