# Dockerizing MongoDB: Dockerfile for building MongoDB images
# Based on ubuntu:latest, installs MongoDB following the instructions from:
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

# Format: FROM    repository[:version]
FROM       ubuntu:latest

# Format: MAINTAINER Name <email@addr.ess>
MAINTAINER Jonas Colmsjö <jonas@gizur.com>

# Installation:
# Import MongoDB public GPG key AND create a MongoDB list file
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

# Update apt-get sources AND install MongoDB
RUN apt-get update
RUN apt-get install -y -q mongodb-org

# It is possible to install a specific version also
# RUN apt-get install -y -q mongodb-org=2.6.1 mongodb-org-server=2.6.1 mongodb-org-shell=2.6.1 mongodb-org-mongos=2.6.1 mongodb-org-tools=2.6.1

# Create the MongoDB data directory
RUN mkdir -p /data/db

ADD ./etc-mongod.conf /etc/mongod.conf

# Expose port 27017 from the container to the host
EXPOSE 27017

# Set usr/bin/mongod as the dockerized entry-point application
ENTRYPOINT usr/bin/mongod


