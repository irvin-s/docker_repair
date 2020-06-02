#
# MongoDB Dockerfile in CentOS 7 image
#

# Build:
# docker build -t zokeber/mongodb:latest .
#
# Create:
# docker create -it -p 27017:27017 --name mongodb zokeber/mongodb
#
# Start:
# docker start mongodb
#
# Connect with mongo
# docker exec -it mongodb mongo
#
# Connect bash
# docker exec -it mongodb bash


# Pull base image
FROM zokeber/centos:latest

# Maintener
MAINTAINER Daniel Lopez Monagas <zokeber@gmail.com>

# Install MongoDB
RUN echo -e "[mongodb]\nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.2/`uname -m`/\ngpgcheck=0\nenabled=1" > /etc/yum.repos.d/mongodb.repo && \
    yum install -y mongodb-org && \
    yum clean all && \
    chown -R mongod:mongod /var/lib/mongo

# Copy config mongodb
COPY etc/ /etc/

# User
USER mongod

# Mountable directories
VOLUME ["/var/lib/mongo"]

# Set the environment variables
ENV HOME /var/lib/mongo

# Working directory
WORKDIR /var/lib/mongo

ENTRYPOINT ["/bin/mongod"]
CMD ["-f", "/etc/mongod.conf"]

# Expose ports.
EXPOSE 27017
