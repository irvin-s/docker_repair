FROM java:7  
COPY ./run.sh /bin/run.sh  
RUN chmod +x /bin/run.sh  
  
ENTRYPOINT ["/bin/run.sh"]  

