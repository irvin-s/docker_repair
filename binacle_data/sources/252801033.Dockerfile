FROM draconrose/serf  
  
ENV SERF_DISCOVER=redis  
  
RUN addgroup -S redis && adduser -S -G redis redis  
  
RUN apk update \  
&& apk add --no-cache 'redis<3.3' 'su-exec=>0.2' \  
&& rm /var/cache/apk/*.tar.gz  
  
COPY include.sh /usr/local/bin/  
  
RUN mkdir /data && chown redis:redis /data  
  
VOLUME /data  
WORKDIR /data  
EXPOSE 6379  
CMD ["redis-server"]  

