#  
# Redis Dockerfile  
# VERSION 3.2  
#  
# Pull Alpine Linux stable base image  
FROM appelgriebsch/alpine:3.6  
MAINTAINER Andreas Gerlach <info@appelgriebsch.com>  
LABEL AUTHOR="Andreas Gerlach <info@appelgriebsch.com>"  
LABEL NAME="redis"  
LABEL VERSION="3.2"  
  
# bind to localhost only (will expose a socket for connection)  
ENV REDIS_BIND 127.0.0.1  
# default tcp port for redis server  
ENV REDIS_PORT 6379  
# default no. of databases  
ENV REDIS_DBCNT 16  
# name of the database dump file  
ENV REDIS_DBFILE redis_01.rdb  
# if master is set, this node is a slave to this master (ip:port)  
# ENV REDIS_MASTER  
# if dbpwd is set, security check is implied  
# ENV REDIS_DBPWD  
# log level of redis server  
ENV REDIS_LOGLVL notice  
  
# install and configure redis  
USER root  
COPY redis.sh /tmp/  
RUN \  
mkdir -p /data/redis && \  
chown -R redis:redis /data/redis && \  
chmod -R 755 /data/redis && \  
chmod 755 /tmp/redis.sh && \  
sed -i "s/^\\(daemonize .*\\)$/# \1/" /etc/redis.conf && \  
sed -i "s/^\\(logfile .*\\)$/# \1/" /etc/redis.conf  
  
# Define mountable directories.  
VOLUME /data/redis  
  
# Define working directory.  
WORKDIR /data/redis  
  
# Expose ports.  
EXPOSE $REDIS_PORT  
  
# run service  
USER redis  
ENTRYPOINT ["/tmp/start_instance.sh", "/tmp/redis.sh"]  

