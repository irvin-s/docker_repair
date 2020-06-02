FROM rabbitmq:3.7.4-management  
  
COPY config/* /etc/rabbitmq/  
  
RUN chown -R rabbitmq:rabbitmq /etc/rabbitmq  
  
CMD ["rabbitmq-server", "-config", "/etc/rabbitmq/advanced.config"]  
  
EXPOSE 61613  

