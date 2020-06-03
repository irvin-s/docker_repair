FROM rabbitmq:3  
RUN rabbitmq-plugins enable rabbitmq_management  
  
EXPOSE 5672 15672

