FROM base_ubuntu

RUN apt-get update
RUN apt-get -y install iputils-ping netcat curl iproute2

# Install MongoDB.
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get install -y mongodb-org && \
  rm -rf /var/lib/apt/lists/*

VOLUME ["/data"]

# Define working directory.
WORKDIR /data

COPY startmongo.sh /root/startmongo.sh

RUN chmod 755 /root/startmongo.sh

# Expose ports.
#   - 27017: process
#   - 28017: http
#EXPOSE 27017
#EXPOSE 28017

# Define default command.
CMD ["/root/startmongo.sh"]
