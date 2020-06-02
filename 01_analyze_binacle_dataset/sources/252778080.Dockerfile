#  
# MongoDB Dockerfile  
# VERSION 3.6  
#  
# Pull Alpine Linux latest base image  
FROM appelgriebsch/alpine:edge  
MAINTAINER Andreas Gerlach <info@appelgriebsch.com>  
LABEL AUTHOR="Andreas Gerlach <info@appelgriebsch.com>"  
LABEL NAME="rabbitmq-server"  
LABEL VERSION="3.6"  
  
# install rabbitmq-server  
USER root  
  
RUN \  
mkdir -p /data/rabbitmq && \  
chown -R rabbitmq:rabbitmq /data/rabbitmq && \  
mkdir -p /etc/rabbitmq && \  
chown -R rabbitmq:rabbitmq /etc/rabbitmq && \  
sed -i "s/\/usr\/lib\/rabbitmq/\/data\/rabbitmq/g" /etc/passwd  
  
# add startup-script  
COPY rabbitmqd.sh /tmp/  
RUN \  
chmod 755 /tmp/rabbitmqd.sh  
  
# environment variables  
ENV RABBITMQ_MNESIA_BASE /data/rabbitmq  
  
# get logs to stdout (thanks @dumbbell for pushing this upstream! :D)  
ENV RABBITMQ_LOGS=- RABBITMQ_SASL_LOGS=-  
  
# Define mountable directories.  
VOLUME /data/rabbitmq  
  
# Define working directory.  
WORKDIR /data/rabbitmq  
  
# Expose public port  
EXPOSE 5672  
# run service  
USER rabbitmq  
ENTRYPOINT ["/tmp/start_instance.sh", "/tmp/rabbitmqd.sh"]  

