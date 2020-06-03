FROM postgres:9.5.2  
COPY run.sh /opt/run.sh  
RUN chmod +x /opt/run.sh  
  
ENTRYPOINT ["/opt/run.sh"]

