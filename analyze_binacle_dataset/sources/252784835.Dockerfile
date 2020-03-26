FROM nanit/rabbitmq:143abaf  
MAINTAINER Josh VanderLinden <codekoala@gmail.com>  
  
RUN rabbitmq-plugins enable rabbitmq_stomp --offline  
  
EXPOSE 61613  

