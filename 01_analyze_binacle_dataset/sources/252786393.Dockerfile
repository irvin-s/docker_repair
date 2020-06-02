FROM dockenizer/rabbitmq  
MAINTAINER Jacques Moati <jacques@moati.net>  
  
RUN rabbitmq-plugins enable \--offline rabbitmq_management  
  
EXPOSE 5672 15672  

