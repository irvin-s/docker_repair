# snakes-on-a-plane: pypi
#
# Reference:
# http://www.plankandwhittle.com/snakes-in-your-datacenter/
# http://bitofcheese.blogspot.com/2013/05/local-pypi-options.html
# https://github.com/botify-labs/docker-localshop

FROM ubuntu:14.04

MAINTAINER Hugh Brown hughdbrown@yahoo.com

# make sure the package repository is up to date
# apt-get -y upgrade &&
# install python packages
# install localshop
# initialize localshop files
# clean up apt store
RUN echo "deb http://archive.ubuntu.com/ubuntu utopic main universe" >> /etc/apt/sources.list && \
    apt-get -y update && \
    apt-get install -y build-essential pkg-config && \
    apt-get install -y sqlite3 && \
    apt-get install -y nginx && \
    apt-get install -y python python-dev python-distribute python-pip && \
    pip install localshop && \
    apt-get clean

# nginx settings
RUN mkdir -p /etc/nginx/{sites-available,sites-enabled}
ADD etc/nginx/sites-available/localshop /etc/nginx/sites-available/

RUN rm /etc/nginx/sites-enabled/default && \
    cd /etc/nginx/sites-enabled && \
    ln -s /etc/nginx/sites-available/localshop localshop

# Upstart config files
ADD *.conf /etc/init/

ADD run/run-localhost.sh /

ENV LOCALSHOP_USER localshop
ENV LOCALSHOP_GROUP localshop
ENV LOCALSHOP_HOME /home/localshop
ENV LOCALSHOP_DB ${LOCALSHOP_HOME}/localshop.db

RUN useradd --user-group \
    --home-dir ${LOCALSHOP_HOME} \
    --create-home \
    --system \
    --shell /bin/bash \
    ${LOCALSHOP_USER}

# Ensure localshop sources directory is writable
RUN mkdir ${LOCALSHOP_HOME}/source && \
    chown -R ${LOCALSHOP_GROUP}:${LOCALSHOP_USER} ${LOCALSHOP_HOME}/source && \
    chmod -R 775 ${LOCALSHOP_HOME}/source

ADD localshop* ${LOCALSHOP_HOME}/

# Ensure localshop db is in read-write mode
RUN chown ${LOCALSHOP_GROUP}:${LOCALSHOP_USER} ${LOCALSHOP_DB} && \
    chmod 775 ${LOCALSHOP_DB}

USER ${LOCALSHOP_USER}
RUN localshop syncdb --noinput && \
    localshop migrate

EXPOSE 8000
VOLUME ["/data"]

# Start localshop
CMD ["/run-localhost.sh"]
