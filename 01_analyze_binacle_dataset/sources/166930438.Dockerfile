# Dockerizing MongoDB: Dockerfile for building MongoDB images
# Based on ubuntu:latest, installs MongoDB following the instructions from:
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

# Format: FROM    repository[:version]
FROM       ubuntu:trusty

# Format: MAINTAINER Name <email@addr.ess>
MAINTAINER Xiyang Chen <settinghead@gmail.com>

# Installation:
# Import MongoDB public GPG key AND create a MongoDB list file
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get install -y mongodb-org && \
  rm -rf /var/lib/apt/lists/*

# # Create the MongoDB data directory
# RUN mkdir -p /data/db

# Define mountable directories.
VOLUME ["/data/db"]

# Define working directory.
WORKDIR /data

# Expose port 27017 from the container to the host
# EXPOSE 27017

# COPY conf/ /conf/

# Set usr/bin/mongod as the dockerized entry-point application
ENTRYPOINT /usr/bin/mongod --port 27017 --dbpath /data/db
