FROM postgres:9.5
MAINTAINER sz

#RUN apt-get update && \
#    apt-get install -y git gcc wget \
#    build-essential libpq-dev postgresql-server-dev-9.5 libtool autoconf automake libcurl4-openssl-dev python ssh gnutls-dev

COPY ./database/config.sh /config.sh
COPY ./database/reset.sh /reset.sh
COPY ./database/python_monitor_schema.sql /python_monitor_schema.sql

ENV libdir=

RUN chmod 700 -R /var/lib/postgresql/data
