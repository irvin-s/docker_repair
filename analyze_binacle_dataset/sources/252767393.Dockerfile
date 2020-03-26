FROM cassandra:2.1  
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*  
  
ADD bootstrap.sh /bootstrap.sh  
ADD JSON.sh /JSON.sh  
  
RUN chmod +x /bootstrap.sh /JSON.sh  
  
ENTRYPOINT ["/bootstrap.sh"]  
  
CMD ["cassandra", "-f"]  

