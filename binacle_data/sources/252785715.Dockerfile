FROM ubuntu:trusty  
  
EXPOSE 3306  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server && \  
rm -rf /var/lib/apt/lists/*  
  
COPY entrypoint.sh /sbin/entrypoint.sh  
RUN chmod 755 /sbin/entrypoint.sh  
  
CMD ["/sbin/entrypoint.sh"]  

