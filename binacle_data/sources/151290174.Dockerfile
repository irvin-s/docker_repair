# Cribbed from github.com/orchardup/docker-mysql/Dockerfile
# Designed to be run with "-p 3306:3306", or referenced by IP

# NOTE: This is a non-persistent container. If you want to non-persist
# the database, make sure you "-v srcdir:/var/lib/mysql" on docker run.

FROM silarsis/base
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>

RUN apt-get -yq install mysql-server

ADD my.cnf /etc/mysql/conf.d/my.cnf
RUN chmod 664 /etc/mysql/conf.d/my.cnf
ADD run-mysql.sh /usr/local/bin/run-mysql.sh
RUN chmod +x /usr/local/bin/run-mysql.sh

EXPOSE 3306
CMD ["/usr/local/bin/run-mysql.sh"]