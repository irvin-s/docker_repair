FROM rabbitmq:latest  
  
RUN rabbitmq-plugins enable rabbitmq_stomp  
RUN rabbitmq-plugins enable rabbitmq_web_stomp  
  
EXPOSE 61613  
EXPOSE 15674

