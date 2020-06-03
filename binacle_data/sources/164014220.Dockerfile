# Postgresql

FROM ubuntu:trusty
MAINTAINER Olivier Hardy "ohardy@me.com"

ADD bin /usr/bin

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen $LANG; echo "LANG=\"${LANG}\"" > /etc/default/locale; dpkg-reconfigure locales

RUN apt-get update
RUN echo mysql-server-5.5 mysql-server/root_password password 'temporary_password' | debconf-set-selections
RUN echo mysql-server-5.5 mysql-server/root_password_again password 'temporary_password' | debconf-set-selections
RUN apt-get -y install mariadb-server-5.5 mariadb-client-5.5

RUN	rm /usr/sbin/policy-rc.d

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

RUN printf '[mysqld]\nskip-name-resolve\n' > /etc/mysql/conf.d/skip-name-resolve.cnf

EXPOSE 3306

CMD ["help"]

ENTRYPOINT ["manage"]
