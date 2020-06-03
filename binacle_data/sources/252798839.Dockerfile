# Version 1.0  
FROM abh1nav/baseimage:latest  
  
MAINTAINER Abhinav Ajgaonkar <abhinav316@gmail.com>  
  
RUN \  
sed -i 's/archive.ubuntu.com/ubuntu.mirror.lrz.de/g' /etc/apt/sources.list; \  
apt-get update; \  
apt-get install -y -qq memcached; \  
mkdir -p /etc/service/memcache  
  
WORKDIR /root  
  
COPY run /etc/service/memcache/  
  
EXPOSE 11211  
CMD ["/sbin/my_init"]

