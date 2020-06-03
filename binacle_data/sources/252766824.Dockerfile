FROM rabbitmq:3.7.3-management  
MAINTAINER Alan Benito <alan.primabudi@wgs.co.id>  
  
RUN rabbitmq-plugins enable rabbitmq_web_stomp --offline  
  
EXPOSE 61613  

