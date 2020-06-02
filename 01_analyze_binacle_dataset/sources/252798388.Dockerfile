# Memcached  
#  
# VERSION 0.0.1  
FROM debian:jessie  
MAINTAINER Deni Bertovic "me@denibertovic.com"  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get -qq -yy update  
RUN apt-get -qq -yy install memcached  
  
ADD start_memcached.sh /usr/local/bin/start_memcached.sh  
RUN chmod +x /usr/local/bin/start_memcached.sh  
  
EXPOSE 11211  
CMD ["/usr/local/bin/start_memcached.sh"]  

