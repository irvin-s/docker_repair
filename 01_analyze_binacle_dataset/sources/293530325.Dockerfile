FROM resin/rpi-raspbian
MAINTAINER gabrielrf
# Originally made by: https://github.com/matteoredaelli/docker-mongodb-rpi

# Install required packages
RUN apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y --no-install-suggests mongodb # && \
    # rm -rf /var/lib/apt/lists/*

# Volumes
VOLUME ["/docker-shares"]
VOLUME ["/var/lib/mongodb"]

# Define default command.
CMD ["mongod"]

# Expose ports.
#   - 27017: process
#   - 28017: http
EXPOSE 27017
EXPOSE 28017

ENTRYPOINT /usr/bin/mongod
