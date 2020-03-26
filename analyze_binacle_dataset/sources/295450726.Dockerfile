
# - Redis Dockerfile
# -
# - https://github.com/dockerfile/redis

FROM ubuntu:latest

ENV RD_SERVER_AUTH 93bdfe5ea84a66d73f3874aa793dc77f0676d67e

# Install Redis.
RUN apt-get update                                                                  && \
    apt-get install -y --no-install-recommends wget                                 && \
    apt-get install -y --no-install-recommends make                                 && \
    apt-get install -y --no-install-recommends build-essential                      && \
    apt-get install -y --no-install-recommends tcl8.5                               && \
    cd /tmp                                                                         && \
    wget http://download.redis.io/releases/redis-3.2.8.tar.gz                       && \
    tar xzf redis-3.2.8.tar.gz                                                      && \
    cd redis-3.2.8                                                                  && \
    make                                                                            && \
    make install                                                                    && \
    cp -f src/redis-sentinel /usr/local/bin                                         && \
    mkdir -p /etc/redis                                                             && \
    cp -f *.conf /etc/redis                                                         && \
    rm -rf /tmp/redis-stable*                                                       && \
    sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf                            && \
    sed -i "s/.*requirepass.*/requirepass ${RD_SERVER_AUTH}/" /etc/redis/redis.conf && \
    sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf                       && \
    sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf                 && \
    sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["redis-server", "/etc/redis/redis.conf"]

# Expose ports.
EXPOSE 6379