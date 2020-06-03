FROM rabbitmq:3.6.15-management  
  
# enable the needed plugins  
RUN rabbitmq-plugins enable \--offline rabbitmq_shovel  
RUN rabbitmq-plugins enable \--offline rabbitmq_shovel_management  
RUN rabbitmq-plugins enable \--offline rabbitmq_federation  
RUN rabbitmq-plugins enable \--offline rabbitmq_federation_management  
  

