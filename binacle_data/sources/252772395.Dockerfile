FROM java:8  
ENV BUILD_NAME gambit-1.0-SNAPSHOT  
  
ENV EXEC_NAME gambit  
  
COPY start_service.sh /home/  
RUN chmod +x /home/start_service.sh  
  
CMD sh /home/start_service.sh  

