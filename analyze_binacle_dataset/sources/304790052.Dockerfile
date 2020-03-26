FROM plabedan/gentoo-minimal

RUN emerge --sync
#RUN emerge -u @world
RUN emerge dev-db/mysql
RUN ( echo '@DB_PASSWORD@' ; echo '@DB_PASSWORD@' ) | emerge dev-db/mysql --config

RUN /usr/bin/mysqld_safe & \
  while ! mysqladmin -uroot -p'@DB_PASSWORD@' ping 2>/dev/null ; do sleep 1; done && \
  mysqladmin -uroot -p'@DB_PASSWORD@' create '@DB_DATABASE@' && \
  mysql -uroot -p'@DB_PASSWORD@' --execute="GRANT ALL ON \`@DB_DATABASE@\`.* TO \`@DB_USER@\`@\`%\` IDENTIFIED BY '@DB_PASSWORD@'" && \
  sed -i -e "s/^bind-address/#&/" /etc/mysql/my.cnf
