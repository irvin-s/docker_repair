##########################
# RethinkDB Dockerfile
#
# Source: https://github.com/dockerfile/rethinkdb
# Added 6 march 2015

# Note: https://github.com/dockerfile/rethinkdb/issues/7

# Pull base image.
FROM ubuntu:15.10
MAINTAINER "Paolo D'Onorio De Meo" p.donoriodemeo@gmail.com

# Install wget to add the apt repo for rethinkdb
RUN apt update && apt install -y wget && apt-get clean

# Prepare script for apt-source
ENV script /tmp/myrethink.sh
RUN echo "source /etc/lsb-release" > $script && \
	echo -n "echo \"deb http://download.rethinkdb.com/apt \$DISTRIB_CODENAME main\" " >> $script && \
	echo " | tee /etc/apt/sources.list.d/rethinkdb.list" >> $script && \
	echo "wget -O- http://download.rethinkdb.com/apt/pubkey.gpg | apt-key add - " >> $script && \
    echo "echo 'Updated sources for RethinkDB ubuntu source'"  >> $script

# Install RethinkDB
RUN bash $script && \
	apt update && apt upgrade -y && \
    apt install -y rethinkdb python-pip && \
	apt-get clean && rm -rf /tmp/*

# Install python driver
RUN pip install rethinkdb

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["rethinkdb", "--bind", "all"]

# Expose ports.
#   - 8080: web UI
#   - 28015: process
#   - 29015: cluster
EXPOSE 8080
EXPOSE 28015
EXPOSE 29015
