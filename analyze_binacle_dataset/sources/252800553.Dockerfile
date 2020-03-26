FROM rabbitmq:3.6.14-management-alpine  
  
MAINTAINER Alexey Zhokhov <alexey@zhokhov.com>  
  
RUN rabbitmq-plugins enable \--offline rabbitmq_federation  
RUN rabbitmq-plugins enable \--offline rabbitmq_federation_management  
RUN rabbitmq-plugins enable \--offline rabbitmq_shovel  
RUN rabbitmq-plugins enable \--offline rabbitmq_shovel_management  
  
EXPOSE 15671 15672  

