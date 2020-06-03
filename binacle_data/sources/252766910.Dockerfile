# Use phusion/baseimage (see https://github.com/phusion/baseimage-docker)  
FROM phusion/baseimage:0.9.13  
MAINTAINER Alban Mouton <alban.mouton@gmail.com>  
  
# Set correct environment variables.  
ENV HOME /root  
ENV DEBIAN_FRONTEND noninteractive  
  
# Use baseimage-docker's init process.  
CMD ["/sbin/my_init"]  
  
# Install rabbitmq  
RUN apt-get -qq update && apt-get install -qq -y rabbitmq-server  
RUN /usr/sbin/rabbitmq-plugins enable rabbitmq_management  
  
# Define mountable directory for rabbitmq data.  
VOLUME ["/data"]  
  
# Configure rabbitmq to write data in /data  
ENV RABBITMQ_BASE /data  
  
# Rabbitmq port  
EXPOSE 5672  
# Management UI  
EXPOSE 15672  
# Clean up APT when done.  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Set the container entry point to rabbitmq executable  
ENTRYPOINT /usr/lib/rabbitmq/bin/rabbitmq-server

