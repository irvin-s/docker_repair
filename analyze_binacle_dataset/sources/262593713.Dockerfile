FROM ubuntu:16.04
MAINTAINER Daniel Guerra

# MOLOCH IDS

# install prerequisites for moloch

# Install curl
RUN apt-get -qq update
# Install the packages
RUN apt-get install -yq curl
# Set the right npm repository for nodejs
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
# Update the repo
RUN apt-get -qq update && apt-get -qq upgrade
# Install the packages
RUN apt-get install -yq  wget curl git sudo libyaml-dev xz-utils gcc pkg-config  g++ flex bison \
                         zlib1g-dev libffi-dev gettext libpcre3-dev uuid-dev libmagic-dev \
                         libgeoip-dev make libjson-perl libbz2-dev libwww-perl libpng-dev yara \
                         libpcap-dev nodejs phantomjs vim net-tools python

# add scripts
ADD /scripts /data
RUN chmod 755 /data/*.sh

# Start building Moloch
RUN /data/buildmoloch.sh /data/moloch-git  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# symlink nodejs for moloch viewer npm
RUN ln -s /usr/bin/nodejs /data/moloch/bin/node
# Add moloch bin path
RUN ln -s /data/moloch/bin/moloch-capture /usr/bin/moloch-capture
RUN ln -s /data/moloch/bin/moloch-capture /usr/bin/capture
# Add moloch config
ADD /etc /data/moloch/etc
# Set volumes
VOLUME ["/data/moloch/logs","/data/moloch/data","/data/moloch/raw","/data/pcap"]
# Set expose port for moloch viewer
EXPOSE 8005

WORKDIR /data/moloch

ENTRYPOINT ["/data/startmoloch.sh"]
