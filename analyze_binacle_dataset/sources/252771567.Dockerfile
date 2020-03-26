FROM ubuntu:14.04  
MAINTAINER info@rentateam.ru  
ENV DEBIAN_FRONTEND=noninteractive \  
REFRESHED_AT=2015-09-03  
# install custom repositories  
RUN apt-get update && apt-get install -y software-properties-common && \  
add-apt-repository -y ppa:rwky/redis  
  
# install packages  
RUN apt-get update && apt-get install -y \  
redis-server  
  
RUN sed -i 's/^\\(bind .*\\)$/# \1/' /etc/redis/redis.conf && \  
sed -i 's/^\\(daemonize .*\\)$/# \1/' /etc/redis/redis.conf && \  
sed -i 's/^\\(dir .*\\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \  
sed -i 's/^\\(logfile .*\\)$/# \1/' /etc/redis/redis.conf  
  
# cleanup  
RUN apt-get clean && rm -rf /var/lib/apt/lists/*  
  
VOLUME ["/data"]  
WORKDIR /data  
  
CMD ["redis-server", "/etc/redis/redis.conf"]  
  
EXPOSE 6379  

