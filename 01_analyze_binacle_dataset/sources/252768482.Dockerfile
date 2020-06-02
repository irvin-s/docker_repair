FROM rabbitmq:3.6-management  
  
RUN apt-get update && apt-get install -y \  
iputils-ping \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY ./rabbitmq.config /etc/rabbitmq/rabbitmq.config  
COPY ./plugins/* $RABBITMQ_HOME/plugins/  
  
RUN rabbitmq-plugins enable autocluster --offline  

