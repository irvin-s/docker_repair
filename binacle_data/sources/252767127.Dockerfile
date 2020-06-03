FROM microsoft/mssql-server-linux:latest  
  
WORKDIR /opt  
  
COPY ./entrypoint.sh /opt/  
COPY ./setup_db.sh /opt/  
  
RUN chmod +x /opt/entrypoint.sh  
RUN chmod +x /opt/setup_db.sh  
  
CMD ["/bin/sh", "/opt/entrypoint.sh"]  

