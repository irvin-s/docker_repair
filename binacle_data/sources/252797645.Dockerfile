FROM registry:2  
ADD config.yml /  
ADD startup.sh /  
  
ENTRYPOINT ["/bin/sh", "-c"]  
  
CMD [ "/startup.sh" ]  
  

