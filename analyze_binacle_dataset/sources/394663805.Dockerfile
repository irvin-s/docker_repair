FROM centos

#RUN mkdir -p /var/lib/mysql

ADD mariadb.repo /etc/yum.repos.d/mariadb.repo
RUN yum install MariaDB-server MariaDB-client -y

EXPOSE 3306

ADD setup-server.sh /setup-server.sh
RUN sh /setup-server.sh

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/usr/bin/mysqld_safe"]
