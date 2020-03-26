FROM ubuntu:16.10  
COPY setup-insecure.sh /setup-insecure.sh  
COPY docker-install.sh /install.sh  
  
RUN chmod +x /*.sh  
RUN /install.sh  
  
ENTRYPOINT ["/setup-insecure.sh"]

