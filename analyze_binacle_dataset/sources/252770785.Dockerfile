FROM ubuntu:16.04  
MAINTAINER agate<agate.hao@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y varnish curl  
  
ADD bootstrap.sh /bootstrap.sh  
  
ENV VCL_CONFIG /etc/varnish/default.vcl  
ENV CACHE_SIZE 64m  
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600  
CMD /bootstrap.sh  
EXPOSE 80  

