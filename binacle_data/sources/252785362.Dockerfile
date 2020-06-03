#  
# Redis Dockerfile  
# Contains basic configuration, with site-specific stuff on the volumes  
#  
FROM colinrhodes/base  
  
MAINTAINER Colin Rhodes <colin@colin-rhodes.com>  
  
ADD redis-bin.tgz /  
  
VOLUME /data/redis  
WORKDIR /data/redis  
  
EXPOSE 6379  
ENTRYPOINT /redis/bin/redis-server --bind 0.0.0.0  

