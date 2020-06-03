# MongoDB (gewo/mongodb)
FROM gewo/base
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>


RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
RUN \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen'\
    | tee /etc/apt/sources.list.d/10gen.list

ADD start_mongodb /usr/local/bin/start_mongodb
RUN chmod 755 /usr/local/bin/start_mongodb

RUN mkdir -p /data/db
RUN mkdir -p /logs
VOLUME ["/data"]
VOLUME ["/logs"]

EXPOSE 27017
EXPOSE 28017
