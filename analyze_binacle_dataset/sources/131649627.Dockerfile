# MySQL Server
# docker pull barnybug/mysql-server
# taken from: https://github.com/kstaken/dockerfile-examples/tree/master/mysql-server
#
# VERSION               0.0.1
FROM ubuntu:12.04
MAINTAINER Barnaby Gray <barnaby@pickle.me.uk>

# install mysql-server
RUN apt-get install -y mysql-server-core-5.5 mysql-client-core-5.5 && apt-get clean
# post installation fixes
ADD my.cnf /etc/mysql/
ADD mysql-setup.sh /tmp/
RUN /tmp/mysql-setup.sh

CMD ["/usr/sbin/mysqld"]
