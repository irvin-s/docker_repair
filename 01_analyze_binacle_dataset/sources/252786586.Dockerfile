FROM docker.io/kibana  
COPY docker-entrypoint.sh /  
RUN chmod 777 /docker-entrypoint.sh  

