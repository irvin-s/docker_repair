FROM rethinkdb/horizon:v2.0.0  
  
ENV PORT 8181  
  
COPY root /  
  
CMD ["/bin/sh", "/opt/horizon/bin/start.sh"]  

