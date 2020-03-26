FROM colstrom/alpine  
  
RUN package install libressl@testing  
  
ENTRYPOINT ["openssl"]  

