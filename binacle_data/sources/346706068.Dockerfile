#
# Redis Dockerfile
#
# https://github.com/dockerfile/redis
#

# Pull base image.
FROM ubuntu

# Install Redis.
RUN \
  cd /tmp && \
  # Modify to stay at this version rather then always update.

  #################################################################
  ###################### REDIS INSTALL ############################
  apt-get update && \
  apt-get install -y libc6-dev && \
  apt-get install -y wget && \
  apt-get install -y make && \
  apt-get install -y gcc

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data


# Print redis configs and start.
# CMD "redis-server /etc/redis/redis.conf"

# Expose ports.
EXPOSE 6379
