FROM centos

#RUN yum update -y
RUN yum install -y mysql-server && /usr/bin/mysql_install_db

RUN /usr/bin/mysqld_safe & \
  while ! mysqladmin ping 2>/dev/null ; do sleep 1; done && \
  mysqladmin create '@DB_DATABASE@' && \
  mysql --execute="GRANT ALL ON \`@DB_DATABASE@\`.* TO \`@DB_USER@\`@\`%\` IDENTIFIED BY '@DB_PASSWORD@'"
