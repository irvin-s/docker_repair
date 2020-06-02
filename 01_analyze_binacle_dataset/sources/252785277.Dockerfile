FROM nsqio/nsq  
  
# Install curl  
RUN apk add --no-cache curl  
  
ADD ./docker-entrypoint.sh /  
RUN chmod +x ./docker-entrypoint.sh  
  
ENTRYPOINT ["/bin/sh", "./docker-entrypoint.sh"]  

