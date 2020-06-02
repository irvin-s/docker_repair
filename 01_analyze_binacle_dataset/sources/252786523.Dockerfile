FROM dockerizedrupal/puppet-debian-wheezy:1.1.3  
MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>  
  
LABEL vendor=dockerizedrupal.com  
  
ENV TERM xterm  
  
ADD ./src /src  
  
RUN /src/entrypoint.sh build  
  
ENTRYPOINT ["/src/entrypoint.sh", "run"]  

