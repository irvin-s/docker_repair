# Openchange development container
FROM ubuntu:14.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes wget

RUN echo "deb http://archive.zentyal.org/zentyal 4.0 main" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.zentyal.org/zentyal 4.0 main" >> /etc/apt/sources.list
RUN wget -q http://keys.zentyal.org/zentyal-4.0-archive.asc -O- | apt-key add -
RUN apt-get update

# Helpers for development
RUN apt-get install -y --force-yes mysql-client

# Openchange packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes samba openchangeserver python-requests python-tz python-mysqldb python-flask
RUN DEBIAN_FRONTEND=noninteractive apt-get build-dep -y --force-yes openchange

VOLUME ["/openchange"]

# Samba conf file enabling OpenChange
ADD smb.conf /etc/samba/smb.conf
ADD openchange_provision.sql /
ADD Makefile /

# MAPI needed ports
EXPOSE 135 389 1024 5001
