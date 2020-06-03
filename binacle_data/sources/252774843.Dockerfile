FROM rabbitmq:3-management-alpine  
MAINTAINER Batuhan KATIRCI <ben@batuhan.org>  
  
ADD rabbitmq_delayed_message_exchange-0.0.1.ez /opt/rabbitmq/plugins  
  
RUN rabbitmq-plugins enable \--offline rabbitmq_delayed_message_exchange  
  

