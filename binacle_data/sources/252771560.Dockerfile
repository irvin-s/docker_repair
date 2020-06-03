FROM djfarrelly/maildev  
  
ADD entrypoint.sh /bin/entrypoint.sh  
RUN chmod 777 /bin/entrypoint.sh  
ENTRYPOINT entrypoint.sh  

