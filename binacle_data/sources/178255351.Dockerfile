## RethinkDB Dockerfile for use with Runbook.io
# This docker container implements rethinkdb with stunnel
# stunnel is used to create encrypted communication between docker instances

FROM ubuntu:latest

MAINTAINER Benjamin Cane <ben@bencane.com>

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget
RUN apt-get install -y python-dev python-pip

# Install RethinkDB.
RUN \
  echo "deb http://download.rethinkdb.com/apt `lsb_release -cs` main" > /etc/apt/sources.list.d/rethinkdb.list && \
  wget -O- http://download.rethinkdb.com/apt/pubkey.gpg | apt-key add - && \
  apt-get update && \
  apt-get install -y rethinkdb

# Install stunnel and supervisor
RUN apt-get install -y stunnel supervisor

# Deploy Config files
RUN mkdir -p /config /data/rethinkdb/data/instances/{{ instance }}
ADD config/supervisord.conf /config/supervisord.conf
ADD config/rethink.conf /config/rethink.conf
ADD config/stunnel-server.conf /config/stunnel-server.conf
ADD config/stunnel-client.conf /config/stunnel-client.conf
ADD config/ssl/key.pem /config/key.pem
ADD config/ssl/cert.pem /config/cert.pem

# Expose Ports
EXPOSE {{ cluster_exposed_port }}
EXPOSE {{ cluster_local_port }}
EXPOSE 28015
EXPOSE 8080

# Run process
CMD /usr/bin/supervisord -c /config/supervisord.conf
