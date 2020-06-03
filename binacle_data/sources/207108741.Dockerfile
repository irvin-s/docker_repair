FROM mysql:5.7
MAINTAINER Sunghoon Kang <me@devholic.io>

ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes \
  MYSQL_DATABASE=goni_saas \
  MYSQL_USER=goni \
  MYSQL_PASSWORD=goni

RUN apt-get update && \
  apt-get install -y --force-yes wget --no-install-recommends && \
  rm -rf /var/lib/apt/lists/* &&  \
  wget -P /docker-entrypoint-initdb.d --no-check-certificate https://raw.githubusercontent.com/monitflux/goni-dashboard/master/db/goniplus.sql &&\
  apt-get -y autoremove wget
