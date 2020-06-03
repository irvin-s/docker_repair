FROM arypurnomoz/sensu:latest  
  
ENV REDIS_PORT 6379  
ENV RABBITMQ_PORT 5671  
ENV RABBITMQ_VHOST /sensu  
ENV RABBITMQ_USER sensu  
ENV RABBITMQ_PASS sensu  
  
ENV API_USER admin  
ENV API_PASS admin  
  
ADD run.sh /tmp/run.sh  
  
# API  
EXPOSE 4567  
ENTRYPOINT ["/tmp/run.sh"]  

