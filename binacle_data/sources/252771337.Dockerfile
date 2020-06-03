FROM rabbitmq:latest  
  
RUN rabbitmq-plugins enable rabbitmq_stomp  
RUN rabbitmq-plugins enable rabbitmq_web_stomp  
RUN rabbitmq-plugins enable \--offline rabbitmq_management  
  
EXPOSE 61613  
EXPOSE 15674  
EXPOSE 15672  

