FROM rabbitmq:3.7  
RUN rabbitmq-plugins enable \--offline rabbitmq_management  
RUN rabbitmq-plugins enable \--offline rabbitmq_mqtt  
  
# Fix nodename  
RUN echo 'NODENAME=rabbit@localhost' > /etc/rabbitmq/rabbitmq-env.conf  
  
EXPOSE 15672  
EXPOSE 1883  
EXPOSE 8883  

