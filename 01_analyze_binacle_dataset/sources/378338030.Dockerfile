FROM        ubuntu:12.10
RUN         apt-get update
RUN         apt-get -y install redis-server
ENTRYPOINT  ["/usr/bin/redis-server"]