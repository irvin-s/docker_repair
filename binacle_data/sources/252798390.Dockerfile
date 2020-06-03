# Redis  
#  
# VERSION 0.0.1  
FROM debian:jessie  
MAINTAINER Deni Bertovic "me@denibertovic.com"  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get -qq -yy update  
RUN apt-get -qq -yy install redis-server  
  
ADD start_redis.sh /usr/local/bin/start_redis.sh  
ADD redis.conf /etc/redis/redis.conf  
RUN chmod +x /usr/local/bin/start_redis.sh  
  
VOLUME ["/var/lib/redis", "/etc/redis"]  
  
EXPOSE 6379  
CMD ["/usr/local/bin/start_redis.sh"]  
  

