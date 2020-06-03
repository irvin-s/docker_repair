FROM ubuntu:16.04  
MAINTAINER Wei-Ming Wu <wnameless@gmail.com>  
  
ADD assets /assets  
RUN /assets/setup.sh  
  
EXPOSE 1521  
EXPOSE 8080  
CMD /usr/sbin/startup.sh && while :; do sleep 10000; done  
  

