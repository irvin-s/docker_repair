FROM ubuntu:16.04  
RUN apt-get update && apt-get install -y apt-utils firefox libglu1  
  
# Called on first run of docker  
ADD /docker-entrypoint.sh /  
RUN chmod 0755 /docker-entrypoint.sh  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["/docker-entrypoint.sh"]  

