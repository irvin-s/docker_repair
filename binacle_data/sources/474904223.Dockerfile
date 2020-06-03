FROM ubuntu:latest

MAINTAINER Esteban Ordano <eordano@gmail.com>

# Download and install nodejs and npm
RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get install -y npm curl git
RUN npm install -g n
RUN n latest

# Shared volume
RUN mkdir -p /var/sherlock
COPY "./package.json" "/var/sherlock/"
WORKDIR "/var/sherlock"

# Install deps
RUN npm install

# Default command for container, start server
CMD ["npm", "start"]

# Expose port 3000 of the container
EXPOSE 3000
