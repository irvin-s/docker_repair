FROM ubuntu:16.04

# Requirements list straight from the cgimap README.
RUN apt-get -qq update --fix-missing && \
	apt-get install -y \
		postgresql-client-9.5 \
		libxml2-dev \
		libpqxx-dev \
		libfcgi-dev \
		libboost-dev \
		libboost-regex-dev \
		libboost-program-options-dev \
		libboost-date-time-dev \
		libboost-filesystem-dev \
		libboost-system-dev \
		libboost-locale-dev \
		libmemcached-dev \
		libcrypto++-dev \
		git \
		build-essential \
		automake \
		autoconf \
		libtool

COPY ./src/cgimap ./cgimap

RUN cd cgimap/ && \
	./autogen.sh && \
	./configure && \
	make install && \
	ldconfig 

ENV CGIMAP_HOST db
ENV CGIMAP_DBNAME openstreetmap
ENV CGIMAP_USERNAME openstreetmap
ENV CGIMAP_PASSWORD openstreetmap
ENV CGIMAP_PIDFILE /dev/null
ENV CGIMAP_LOGFILE /dev/stdout
ENV CGIMAP_MEMCACHE memcached
ENV CGIMAP_RATELIMIT 204800
ENV CGIMAP_MAXDEBT 250

ENV SCRIPT_PATH /usr/local/scripts

ADD scripts/ $SCRIPT_PATH
RUN chmod +x $SCRIPT_PATH/*.sh

EXPOSE 3001

ENTRYPOINT $SCRIPT_PATH/docker-entrypoint.sh
