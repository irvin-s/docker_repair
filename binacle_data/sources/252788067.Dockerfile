FROM debian:wheezy  
  
MAINTAINER crazycode  
ENV DEBIAN_FRONTEND noninteractive  
  
ENV MAX_MEM 64  
ENV MAX_CONN 1024  
RUN apt-get --assume-yes --quiet update && \  
apt-get --assume-yes --quiet --no-install-recommends install memcached  
  
EXPOSE 11211  
CMD exec /usr/bin/memcached -u nobody -v -m $MAX_MEM -c $MAX_CONN  

