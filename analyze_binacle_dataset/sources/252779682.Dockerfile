FROM compulsivecoder/ubuntu-mono:latest  
  
RUN apt-get update && apt-get install -y redis-server  
  
# Define mountable directories.  
VOLUME ["/data"]  
  
# Define working directory.  
WORKDIR /data  
  
# Define default command.  
#CMD ["redis-server", "/etc/redis/redis.conf"]  
EXPOSE 6379  
ENTRYPOINT ["/usr/bin/redis-server", "/etc/redis/redis.conf"]  

