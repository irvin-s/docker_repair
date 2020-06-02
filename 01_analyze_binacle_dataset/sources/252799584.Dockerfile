FROM dickeyxxx/base  
MAINTAINER Jeff Dickey jeff@dickeyxxx.com  
EXPOSE 6379  
RUN apt-get -y install redis-server  
RUN apt-get clean  
  
CMD ["/usr/bin/redis-server"]  

