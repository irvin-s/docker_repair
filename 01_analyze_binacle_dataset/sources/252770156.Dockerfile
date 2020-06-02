FROM elasticsearch  
  
COPY run.sh /  
  
ENTRYPOINT ["/run.sh"]  
  

