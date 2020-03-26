FROM rabbitmq  
  
COPY init.sh /  
  
RUN chmod +x init.sh  
  
CMD ["/init.sh"]  

