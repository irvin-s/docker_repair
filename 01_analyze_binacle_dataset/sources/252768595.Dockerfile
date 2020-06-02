FROM alpine:latest  
MAINTAINER Anastas Dancha <anapsix@random.io>  
  
RUN apk upgrade --update && \  
apk add redis && \  
sed -i '/^daemonize/s/yes/no/g' /etc/redis.conf && \  
sed -i 's/^logfile/#logfile/g' /etc/redis.conf  
  
COPY gosu /bin/gosu  
ADD docker-entrypoint.sh /entrypoint.sh  
  
VOLUME /var/lib/redis  
EXPOSE 6379  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["start"]  

