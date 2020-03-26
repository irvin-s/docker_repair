FROM alpine  
COPY bin/enforcer /enforcer  
RUN chmod +x /enforcer  
  
EXPOSE 8813  
#ENTRYPOINT ["/enforcer"]  
#CMD [-h]  

