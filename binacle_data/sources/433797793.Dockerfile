FROM postgres:9.3
MAINTAINER Akvo Foundation <devops@akvo.org>

# Capture build-time variables
ARG v
ENV V ${v:-0.7.3}

# Configure locales
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8

# Install build dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    software-properties-common \
    proj-bin proj-data libproj-dev \
    libjson0 libjson0-dev python-simplejson \
    libgeos-c1 libgeos-dev \
    gdal-bin libgdal1-dev \
    libxml2-dev \
    liblwgeom-2.1.4 postgis postgresql-9.3-postgis-2.2 postgresql-9.3-postgis-scripts \
    libpq5 libpq-dev \
    postgresql-contrib-9.3 postgresql-server-dev-9.3 postgresql-plpython-9.3 \
    sudo \
    git && \
    rm -rf /var/lib/apt/lists/*

# Add further initialization steps required by cartoDB
ADD ./initdb.d/cartodb.sh /docker-entrypoint-initdb.d/cartodb.sh
