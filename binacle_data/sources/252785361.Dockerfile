#  
# Rabbitmq Dockerfile  
# Sets up a basic Rabbitmq server  
#  
FROM colinrhodes/base  
  
MAINTAINER Colin Rhodes <colin@colin-rhodes.com>  
  
ADD rabbitmq.list /etc/apt/sources.list.d/rabbitmq.list  
ADD http://www.rabbitmq.com/rabbitmq-signing-key-public.asc rabbitmq.asc  
RUN apt-key add rabbitmq.asc && rm rabbitmq.asc  
RUN apt-get update -yq  
RUN apt-get install -yq rabbitmq-server  
  
EXPOSE 5672 25672 4369  
VOLUME /data/rabbitmq  
  
ENV RABBITMQ_BASE /data/rabbitmq  
  
ENTRYPOINT /usr/sbin/rabbitmq-server  

