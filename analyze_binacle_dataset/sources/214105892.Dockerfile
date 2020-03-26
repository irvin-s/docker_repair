#
# Redis Dockerfile
#
# https://github.com/dockerfile/redis
#

# Pull base image.
FROM base/arch_plus

# Install Redis.
RUN pacman -Syuu --noconfirm
RUN pacman -S redis --noconfirm

# Configure Redis.
RUN \
  sed -i 's/^\(bind .*\)$/# \1/' /etc/redis.conf && \
  sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis.conf && \
  sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis.conf && \
  sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis.conf

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["redis-server", "/etc/redis.conf"]

# Expose ports.
EXPOSE {{{port}}}
