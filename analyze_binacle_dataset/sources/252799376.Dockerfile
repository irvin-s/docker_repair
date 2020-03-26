FROM frapsoft/typescript  
  
ADD ./app /app  
  
USER root  
  
RUN chown -R app /app  
  
USER app  
  
ENTRYPOINT ["sh"]  

