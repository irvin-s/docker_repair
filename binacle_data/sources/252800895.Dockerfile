FROM jordi/openssl  
  
COPY entrypoint.sh .  
RUN chmod +rx entrypoint.sh  
  
ENTRYPOINT ["./entrypoint.sh" ]  
  

