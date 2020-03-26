FROM alpine:3.6  
LABEL maintainer "Adrian Riobo Lorenzo <adrian.riobo.lorenzo@gmail.com>"  
  
COPY docker-entrypoint.sh create_cluster.sh.tpl /usr/local/bin/  
  
ENV REDIS_VERSION 4.0.2  
ENV REDIS_BINARY redis-$REDIS_VERSION.tar.gz  
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/$REDIS_BINARY  
  
RUN apk add --update ruby \  
&& gem install redis --no-document \  
&& wget -P /tmp $REDIS_DOWNLOAD_URL \  
&& tar -xzvf /tmp/$REDIS_BINARY \  
&& rm /tmp/$REDIS_BINARY \  
&& cp /redis-$REDIS_VERSION/src/redis-trib.rb /usr/local/bin/ \  
&& rm -r /redis-$REDIS_VERSION \  
&& find /usr/local/bin -name "*.sh" -exec chmod +x {} \;  
  
ENTRYPOINT ["docker-entrypoint.sh"]  
  
CMD ["create_cluster.sh"]  

