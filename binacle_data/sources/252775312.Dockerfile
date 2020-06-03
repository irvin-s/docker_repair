FROM rabbitmq:3  
RUN rabbitmq-plugins enable \--offline rabbitmq_web_stomp  
  
EXPOSE 15674  

