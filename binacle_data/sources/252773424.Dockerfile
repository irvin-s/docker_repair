FROM ubuntu:14.04  
# Prepare the environment  
ADD init-docker.sh /opt  
  
# Add entrypoint  
ADD entrypoint.sh /opt/zookeeper-3.5.2-alpha/bin/  
RUN chmod 777 /opt/zookeeper-3.5.2-alpha/bin/entrypoint.sh  
  
# Add versioning details  
ADD version.json /opt  
  
EXPOSE 2181 2888 3888  
ENTRYPOINT ["/opt/zookeeper-3.5.2-alpha/bin/entrypoint.sh"]  

