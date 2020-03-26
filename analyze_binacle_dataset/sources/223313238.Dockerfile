# The simplest possible configuration to run LDFF without cluttering your host system.
# Usage:
#
#   docker build -t thomastc/ldff
#   docker volume create --name mysql
#   ./run_in_docker.sh  # keep this running in a separate terminal
#   ./docker_shell.sh
#       mysql -uroot -p neijUsItAgvosht
#           create database ldff;
#           exit
#       exit
#
# Access the site at http://localhost:8080.
#
# THIS IS JUST FOR TESTING. IT'S PROBABLY ENTIRELY INSECURE AND INEFFICIENT. DO
# NOT USE FOR A PRODUCTION SETUP WITHOUT FURTHER ADJUSTMENTS.

FROM debian:8.5

RUN apt-get -qy update
RUN apt-get -qy upgrade

RUN echo "mysql-server mysql-server/root_password select neijUsItAgvosht" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again select neijUsItAgvosht" | debconf-set-selections
RUN apt-get -qy install apache2 mysql-server php5 php5-mysqlnd php5-apcu supervisor

RUN systemctl disable apache2
RUN systemctl disable mysql

ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
