FROM        ubuntu
RUN         apt-get update
RUN         apt-get -y install redis-server
EXPOSE      6379
ENTRYPOINT  ["/usr/bin/redis-server"]
