FROM dockerizedrupal/base-debian-jessie:2.0.0  
MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>  
  
LABEL vendor=dockerizedrupal.com  
  
ENV TERM xterm  
  
ADD ./src /src  
  
RUN /src/entrypoint.sh build  
  
ENTRYPOINT ["/src/entrypoint.sh", "run"]  

