#  
# MongoDB Dockerfile  
# VERSION 3.4  
#  
# Pull Alpine Linux latest base image  
FROM quay.io/appelgriebsch/alpine:3.7  
MAINTAINER Andreas Gerlach <info@appelgriebsch.com>  
LABEL AUTHOR="Andreas Gerlach <info@appelgriebsch.com>"  
LABEL NAME="mongodb"  
LABEL VERSION="3.4"  
  
# bind to localhost only (will expose a socket for connection)  
ENV MONGO_BIND 127.0.0.1  
# default tcp port for mongo server  
ENV MONGO_PORT 27017  
# verbose log level of mongodb server (0-5)  
ENV MONGO_LOGLVL 0  
# mode of node (e.g. normal, arbiter, config, shard)  
ENV MONGO_TYPE normal  
# name of replica set (if available)  
# ENV MONGO_REPLSET  
# address of master server (ip:port)  
# ENV MONGO_MASTER  
# address of config server (ip:port)  
# ENV MONGO_CONFIG  
# install mongodb and create a default YAML config file  
USER root  
  
RUN \  
mkdir -p /data/mongodb && \  
chown -R mongodb:nobody /data/mongodb && \  
chmod -R 755 /data/mongodb && \  
echo "# new YAML based config file for mongodb > 2.6" > /etc/mongod.conf && \  
echo "processManagement.fork: false" >> /etc/mongod.conf && \  
echo "systemLog.verbosity: 0" >> /etc/mongod.conf && \  
echo "net.bindIp: 127.0.0.1" >> /etc/mongod.conf && \  
echo "net.port: 27017" >> /etc/mongod.conf && \  
echo "storage.dbPath: /data/mongodb" >> /etc/mongod.conf && \  
echo "storage.directoryPerDB: true" >> /etc/mongod.conf && \  
echo "storage.mmapv1.smallFiles: true" >> /etc/mongod.conf && \  
echo "storage.journal.enabled: true" >> /etc/mongod.conf  
  
# add startup-script  
COPY mongod.sh /tmp/  
RUN \  
chmod 755 /tmp/mongod.sh  
  
# Define mountable directories.  
VOLUME /data/mongodb  
  
# Define working directory.  
WORKDIR /data/mongodb  
  
# Expose ports (mongodb - 27017, config-srv - 27018, shard-srv - 27019)  
EXPOSE $MONGO_PORT  
  
# run service  
USER mongodb  
CMD ["/tmp/mongod.sh"]  

