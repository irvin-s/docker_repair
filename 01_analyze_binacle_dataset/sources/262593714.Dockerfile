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
RUN apt-get install -yq  vim net-tools curl wget sudo gdebi-core nodejs phantomjs
WORKDIR /tmp
# get moloch debian package
RUN wget https://files.molo.ch/builds/ubuntu-16.04/moloch_0.18.2-1_amd64.deb
#install moloch debian package
RUN gdebi -n moloch_0.18.2-1_amd64.deb
#fix moloch's dependencies
RUN apt-get -qq upgrade && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add moloch config
ADD /etc /data/moloch/etc

# add scripts
ADD /scripts /data
RUN chmod 755 /data/*.sh

#docker stuff
VOLUME ["/data/moloch/logs","/data/moloch/data","/data/moloch/raw","/data/pcap"]
EXPOSE 8005
WORKDIR /data/moloch

#ENTRYPOINT ["/data/startmoloch.sh"]
