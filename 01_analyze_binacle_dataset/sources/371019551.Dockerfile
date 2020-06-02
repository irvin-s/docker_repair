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
RUN apt-get -y install postgresql-9.3 postgresql-contrib-9.3 postgresql-client-9.3

RUN	rm /usr/sbin/policy-rc.d
RUN echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/9.3/main/pg_hba.conf
RUN ex -sc "%s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" -c "x" /etc/postgresql/9.3/main/postgresql.conf
RUN touch /root/.psql_history

EXPOSE 5432

CMD ["help"]

ENTRYPOINT ["manage"]
