FROM arypurnomoz/sensu:latest  
  
ENV REDIS_PORT 6379  
ENV RABBITMQ_PORT 5671  
ENV RABBITMQ_VHOST /sensu  
ENV RABBITMQ_USER sensu  
ENV RABBITMQ_PASS sensu  
  
ADD run.sh /tmp/run.sh  
  
ENTRYPOINT ["/tmp/run.sh"]  

