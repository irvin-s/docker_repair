FROM postgres:9.5  
MAINTAINER agate<agate.hao@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y curl  
  
ADD bootstrap.sh /bootstrap.sh  
  
ENTRYPOINT ["/bootstrap.sh"]  
CMD ["postgres"]  

