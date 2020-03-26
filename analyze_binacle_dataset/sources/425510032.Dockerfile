FROM debian:wheezy

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && echo 'deb http://ftp.osuosl.org/pub/mariadb/repo/5.5/debian wheezy main' > /etc/apt/sources.list.d/mariadb.list

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq procps mariadb-server

RUN sed -ri 's/^(bind-address|skip-networking)/;\1/' /etc/mysql/my.cnf

# wrapper to do prep & run mysqld_safe
ADD prep_and_mysqld_safe /usr/sbin/prep_and_mysqld_safe

RUN cp -Rip /var/lib/mysql /var/lib/orig-mysql

VOLUME /var/lib/mysql
EXPOSE 3306

#As per: https://github.com/dockerfile/mariadb/issues/3
ENV TERM dumb

CMD [ "/usr/sbin/prep_and_mysqld_safe", "--skip-syslog" ]
