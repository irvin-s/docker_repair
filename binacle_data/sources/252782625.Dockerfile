FROM cleardevice/docker-alpine-init  
  
ENV REDIS_CONF=/etc/redis.conf  
  
RUN apk add --update-cache redis && \  
sed -i 's/^\\(bind .*\\)$/# \1/' ${REDIS_CONF} && \  
sed -i 's/^\\(daemonize .*\\)$/# \1/' ${REDIS_CONF} && \  
sed -i 's/^\\(dir .*\\)$/# \1\ndir \/data/' ${REDIS_CONF} && \  
sed -i 's/^\\(logfile .*\\)$/# \1/' ${REDIS_CONF} && \  
sed -i 's/^\\(appendonly .*\\)$/# \1\nappendonly yes/' ${REDIS_CONF} && \  
rm -rf /var/cache/apk/*  
  
VOLUME /data  
WORKDIR /data  
  
ADD etc /etc  
  
EXPOSE 6379  

