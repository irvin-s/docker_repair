FROM rabbitmq:management  
  
COPY run.sh /  
RUN chmod 755 ./*.sh  
  
CMD ["./run.sh"]

