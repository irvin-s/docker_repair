FROM dockerizedrupal/base-debian-jessie:2.0.0  
MAINTAINER Jürgen Viljaste <j.viljaste@gmail.com>  
  
LABEL vendor=dockerizedrupal.com  
  
ENV TERM xterm  
  
ADD ./src /src  
  
RUN /src/entrypoint.sh build  
  
EXPOSE 80  
EXPOSE 443  
EXPOSE 25  
ENTRYPOINT ["/src/entrypoint.sh", "run"]  

