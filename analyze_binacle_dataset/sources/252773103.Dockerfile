FROM bezrukovp/main-base  
MAINTAINER Pavel Bezrukov "bezrukov.ps@gmail.com"  
# Install db server  
RUN apt-get -y -q install memcached  
  
EXPOSE 11211  
CMD ["/usr/bin/memcached", "-u", "memcache", "-v"]  

