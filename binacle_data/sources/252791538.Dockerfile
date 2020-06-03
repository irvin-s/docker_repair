FROM mongo  
  
COPY mongorestore-verify /usr/bin/mongorestore-verify  
RUN chmod 755 /usr/bin/mongorestore-verify  
  
CMD /usr/bin/mongorestore-verify  

