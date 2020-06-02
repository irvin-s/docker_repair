# c12e/universal  
FROM c12e/neo4j:2.2.0  
MAINTAINER CogntiveScale.com  
  
ADD neo4j-server.properties /opt/neo4j/conf/neo4j-server.properties  
  
# Ports  
EXPOSE 5074  
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]  

