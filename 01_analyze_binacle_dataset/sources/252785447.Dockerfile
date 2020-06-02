FROM colstrom/alpine  
  
RUN apk-install nodejs  
  
ENTRYPOINT ["node"]  

