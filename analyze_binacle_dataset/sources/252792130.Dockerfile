FROM chastell/trusty  
  
MAINTAINER Piotr Szotkowski <chastell@chastell.net>  
  
RUN apt-get update  
RUN apt-get install --assume-yes redis-server  
RUN apt-get clean  
  
ADD files/etc /etc  
ADD files/usr /usr  
  
VOLUME /var/lib/redis  
  
EXPOSE 6379  
CMD /usr/local/bin/setup_and_start_redis.sh  

