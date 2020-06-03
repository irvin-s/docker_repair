FROM couchbase/server  
  
ENV ADMIN_LOGIN=root  
ENV ADMIN_PASSWORD=foobar  
ENV CLUSTER_RAM_QUOTA=1024  
  
COPY init.sh /  
  
ENTRYPOINT ["/init.sh"]  
  
EXPOSE 8091  
  

